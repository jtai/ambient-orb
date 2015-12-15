require 'spec_helper'

describe AmbientOrb do

  let (:options) { {} }
  let (:orb) { AmbientOrb.new(options) }

  describe '#device' do

    context 'with valid device option' do
      let (:options) { { :device => '/dev/zero' } }

      it 'returns device' do
        expect(orb.device).to eq('/dev/zero')
      end
    end

    context 'with non-existent device' do
      let (:options) { { :device => '/dev/nosuchdevice' } }

      it 'raises ArgumentError' do
        expect {
          orb.device
        }.to raise_error(ArgumentError)
      end
    end

    context 'with block device' do
      let (:options) { { :device => `df #{__FILE__} | tail -1 | cut -d ' ' -f 1` } }

      it 'raises ArgumentError' do
        expect {
          orb.device
        }.to raise_error(ArgumentError)
      end
    end

    context 'with autodetected device' do
      it 'returns first device matching pattern' do
        expect(Dir).to receive(:glob).and_return(['/dev/urandom', '/dev/random'])
        expect(orb.device).to eq('/dev/urandom')
      end
    end

  end

  describe '#update' do

    let (:color) { AmbientOrb::COLOR_RED }
    let (:animation) { AmbientOrb::ANIMATION_NONE }

    context 'with out of range color' do
      let (:color) { 37 }

      it 'raises ArgumentError' do
        expect {
          orb.update(color, animation)
        }.to raise_error(ArgumentError)
      end
    end

    context 'with out of range animation' do
      let (:animation) { 10 }

      it 'raises ArgumentError' do
        expect {
          orb.update(color, animation)
        }.to raise_error(ArgumentError)
      end
    end

    context 'with valid arguments' do
      it 'sends correct update' do
        expect(orb).to receive(:send).with('~A  ')
        orb.update(color, animation)
      end
    end

    context 'with purple color' do
      let (:color) { AmbientOrb::COLOR_PURPLE }

      it 'sends correct update' do
        expect(orb).to receive(:send).with('~A ;')
        orb.update(color, animation)
      end
    end

    context 'with fast animation' do
      let (:animation) { AmbientOrb::ANIMATION_FAST }

      it 'sends correct update' do
        expect(orb).to receive(:send).with('~A"B')
        orb.update(color, animation)
      end
    end

  end

  describe '#send' do

    let (:io) { IO.new }

    it 'sends commands' do
      io = double('serial_port')
      expect(io).to receive(:puts).with('~GT')
      expect(io).to receive(:puts).with('~A  ')
      expect(SerialPort).to receive(:open).and_yield(io)
      orb.update(AmbientOrb::COLOR_RED, AmbientOrb::ANIMATION_NONE)
    end

  end

end
