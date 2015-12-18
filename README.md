AmbientOrb
===========

Ruby code to interface with ambientdevices Ambient Orb. Only supports the
serial interface as ambientdevices' service no longer exists.

```ruby
require 'ambient-orb'

# device is automatically detected on OS X
orb = AmbientOrb.new

# a device can be passed manually
#orb = AmbientOrb.new(:device => '/dev/ttyS0')

# a logger can also be passed
#orb = AmbientOrb.new(:logger => Logger.new(STDOUT))
#orb.logger.level = Logger::DEBUG

[
  [ AmbientOrb::COLOR_GREEN,  AmbientOrb::ANIMATION_VERY_SLOW   ],
  [ AmbientOrb::COLOR_BLUE,   AmbientOrb::ANIMATION_SLOW        ],
  [ AmbientOrb::COLOR_PURPLE, AmbientOrb::ANIMATION_MEDIUM_SLOW ],
  [ AmbientOrb::COLOR_YELLOW, AmbientOrb::ANIMATION_MEDIUM      ],
  [ AmbientOrb::COLOR_ORANGE, AmbientOrb::ANIMATION_FAST        ],
  [ AmbientOrb::COLOR_RED,    AmbientOrb::ANIMATION_VERY_FAST   ],
].each do |(color, animation)|
  orb.update(color, animation)
  sleep(10)
end
```

## Hardware Setup

This gem has been tested with two hardware setups.

### Arduino Uno R3

Using the Arduino Uno R3 as a [USB to serial TTL converter](http://www.princetronics.com/arduino-uno-as-usb-to-serial-ttl-converter/). The R3 uses an atmega16u2 chip.

 * Connect Pin 5 (RX) on the Orb to Pin 0 (RX) on the Arduino.
 * Connect Pin 6 (TX) on the Orb to Pin 1 (TX) on the Arduino.
 * Connect RESET to GND on the Arduino.

### FT232R USB to 5V TTL level UART cable

Using the [EZSync FTDI chip usb to 5v TTL UART serial cable, connector end, 1.5m, TTL-232R-5V compatible](http://www.amazon.com/gp/product/B010KII6VG?psc=1&redirect=true&ref_=oh_aui_detailpage_o00_s00) cable. This cable uses the FT232R chip.

 * Connect Pin 5 (RX) on the Orb to Pin 4 (TXD, Orange) on the cable.
 * Connect Pin 6 (TX) on the Orb to Pin 5 (RXD, Yellow) on the cable.

