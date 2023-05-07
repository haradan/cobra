module Nrdb
  class Connection
    def initialize(user = nil, access_token = nil)
      @user = user
      @access_token = access_token || user.try(:nrdb_access_token)
    end

    def player_info
      resp = connection.get('/api/2.0/private/account/info')
      raise 'NRDB API connection failed' unless resp.success?

      JSON.parse(resp.body).with_indifferent_access[:data]
    end

    def decks
      resp = connection.get('/api/2.0/private/decks')
      raise 'NRDB API connection failed' unless resp.success?

      data = JSON.parse(resp.body).with_indifferent_access[:data]
      lookup_identities(data).sort_by { |d| -(d[:date_update] || '').to_datetime.to_i }
    end

    def cards
      resp = public_connection.get('/api/2.0/public/cards')
      raise 'NRDB API connection failed' unless resp.success?

      JSON.parse(resp.body).with_indifferent_access[:data]
    end

    def update_cards
      all_cards = cards
      Card.upsert_all all_cards.map { |card| {
        nrdb_code: card[:nrdb_code],
        title: card[:title],
        side_code: card[:side_code],
        faction_code: card[:faction_code],
        type_code: card[:type_code]
      } }

      identities = all_cards.select { |card| card[:type_code] == "identity" }
      Identity.upsert_all identities.map { |id| {
        nrdb_code: id[:nrdb_code],
        name: id[:title],
        side: id[:side_code],
        faction: id[:faction_code],
        autocomplete: id[:title]
      } }

      Identity.where(nrdb_code: '10030').update(
        autocomplete: 'Palana Foods: Sustainable Growth'
      )
      Identity.where(nrdb_code: ['02046', '20037']).update(
        autocomplete: 'Chaos Theory: Wunderkind'
      )
    end

    private

    attr_reader :access_token

    def connection
      # TODO: allow the NRDB url to be configurable for local testing.
      @connection ||= Faraday.new(url: "https://netrunnerdb.com") do |conn|
        conn.adapter :net_http
        conn.headers[:Authorization] = "Bearer #{access_token}"
      end
    end

    def public_connection
      @connection ||= Faraday.new(url: "https://netrunnerdb.com") do |conn|
        conn.adapter :net_http
      end
    end

    def lookup_identities(decks)
      card_codes = decks.flat_map { |deck| (deck[:cards] || {}).keys }.uniq
      code_to_identity = Identity.where(nrdb_code: card_codes)
                                 .to_h { |identity| [identity.nrdb_code, identity] }
      decks.map do |deck|
        identity = lookup_identity(deck, code_to_identity)
        deck.merge({ :identity => identity, :side => identity ? identity.side : nil }.compact)
      end
    end

    def lookup_identity(deck, code_to_identity)
      (deck[:cards] || {}).keys
                          .flat_map { |code| code_to_identity[code] || [] }
                          .first
    end
  end
end
