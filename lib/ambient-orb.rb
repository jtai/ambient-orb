require 'ambient-orb/version'

class AmbientOrb

  def initialize(options = {})
    @opts = options
  end

  def device
    @device ||= begin
      dev = @opts[:device] || autodetect_device

      unless dev && File.exist?(dev) && File.stat(dev).chardev?
        raise ArgumentError, 'invalid device'
      end

      dev
    end
  end

  private

  def autodetect_device
    Dir.glob('/dev/*.usbmodem*').first
  end

end
