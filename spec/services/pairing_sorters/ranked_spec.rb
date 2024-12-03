# frozen_string_literal: true

RSpec.describe PairingSorters::Ranked do
  let(:player1) { PairingStrategies::PlainPlayer.new(1, 'Jason', true, false, points: 3) }
  let(:player2) { PairingStrategies::PlainPlayer.new(2, 'Mike', true, false, points: 1) }
  let(:player3) { PairingStrategies::PlainPlayer.new(3, 'Amy', true, false, points: 6) }
  let(:player4) { PairingStrategies::PlainPlayer.new(4, 'Disha', true, false) }
  let(:player5) { PairingStrategies::PlainPlayer.new(5, 'Sabrina', true, false, points: 3) }
  let(:player6) { PairingStrategies::PlainPlayer.new(6, 'Danny', true, false, points: 2) }

  let(:pairing1) { PairingStrategies::PlainPairing.new(player1, 0, player2, 0) }
  let(:pairing2) { PairingStrategies::PlainPairing.new(player3, 0, player4, 0) }
  let(:pairing3) { PairingStrategies::PlainPairing.new(player5, 0, player6, 0) }
  let(:pairings) { [pairing1, pairing2, pairing3] }

  it 'sorts pairings by highest-scoring participant' do
    expect(described_class.sort(pairings)).to eq([pairing2, pairing3, pairing1])
  end

  context 'odd number of players' do
    let(:pairing3) { PairingStrategies::PlainPairing.new(player5, 0, nil, 0) }

    it 'sorts correctly' do
      expect(described_class.sort(pairings)).to eq([pairing2, pairing1, pairing3])
    end
  end
end
