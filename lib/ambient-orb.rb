require 'ambient-orb/version'
require 'serialport'

class AmbientOrb

  # These are fixed characteristics of the orb.
  SERIAL_PORT_BAUD_RATE = 19200
  SERIAL_PORT_DATA_BITS = 8
  SERIAL_PORT_STOP_BITS = 1
  SERIAL_PORT_PARITY    = SerialPort::NONE

  # Colors are specified as an integer from 0 to 36, inclusive. Common colors
  # are assigned constants for convenience.
  COLOR_RED    = 0
  COLOR_ORANGE = 3
  COLOR_YELLOW = 6
  COLOR_GREEN  = 12
  COLOR_BLUE   = 24
  COLOR_PURPLE = 27

  # Animation is specified as an integer from 0 to 9, inclusive.
  ANIMATION_NONE        = 0
  ANIMATION_VERY_SLOW   = 1
  ANIMATION_SLOW        = 2
  ANIMATION_MEDIUM_SLOW = 3
  ANIMATION_MEDIUM      = 4
  ANIMATION_MEDIUM_FAST = 5
  ANIMATION_FAST        = 6
  ANIMATION_VERY_FAST   = 7
  ANIMATION_CRESCENDO   = 8
  ANIMATION_HEARTBEAT   = 9

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

  def update(color, animation)
    if (color < 0 || color > 36)
      raise ArgumentError, 'color must be between 0 and 36'
    end

    if (animation < 0 || animation > 9)
      raise ArgumentError, 'animation must be between 0 and 9'
    end

    color_ord     = (color + (37 * animation)) / 94 + 32
    animation_ord = (color + (37 * animation)) % 94 + 32

    send("~A#{color_ord.chr}#{animation_ord.chr}")
  end

  private

  def autodetect_device
    Dir.glob('/dev/*.usbmodem*').first
  end

  def send(command)
    SerialPort.open(device,
                    SERIAL_PORT_BAUD_RATE,
                    SERIAL_PORT_DATA_BITS,
                    SERIAL_PORT_STOP_BITS,
                    SERIAL_PORT_PARITY) do |serial_port|
      serial_port.puts '~GT'
      serial_port.puts command
    end
  end

end
