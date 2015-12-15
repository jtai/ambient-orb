require 'ambient-orb/version'

class AmbientOrb

  def initialize(options = {})
    @opts = options
  end

  def device
    @device ||= begin
      if @opts[:device]
        @opts[:device]
      else
        autodetect_device
      end
    end
  end

  private

  def autodetect_device
    Dir.glob('/dev/*.usbmodem*').first
  end

end
