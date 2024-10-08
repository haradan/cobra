# frozen_string_literal: true

RSpec.describe TournamentsController do
  let(:tournament) { create(:tournament, name: 'My Tournament') }

  describe '#save_json' do
    before do
      allow(NrtmJson).to receive(:new).with(tournament).and_return(
        instance_double(NrtmJson, data: { some: :data })
      )
    end

    it 'responds with json file' do
      get save_json_tournament_path(tournament)

      expect(response.headers['Content-Disposition']).to eq(
        'attachment; filename="my tournament.json"; filename*=UTF-8\'\'my%20tournament.json'
      )
      expect(response.body).to eq('{"some":"data"}')
    end
  end

  describe '#cut' do
    let(:cut) { create(:stage, tournament:) }

    before do
      allow(Tournament).to receive(:find)
        .with(tournament.to_param)
        .and_return(tournament)
      allow(tournament).to receive(:cut_to!).and_return(cut)
    end

    it 'cuts tournament' do
      sign_in tournament.user
      post cut_tournament_path(tournament), params: { number: 8 }

      expect(tournament).to have_received(:cut_to!).with(:double_elim, 8)
    end
  end
end
