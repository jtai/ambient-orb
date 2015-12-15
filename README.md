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
  [ AmbientOrb::COLOR_GREEN,  AmbientOrb::ANIMATION_VERY_SLOW ],
  [ AmbientOrb::COLOR_BLUE,   AmbientOrb::ANIMATION_SLOW ],
  [ AmbientOrb::COLOR_PURPLE, AmbientOrb::ANIMATION_MEDIUM_SLOW ],
  [ AmbientOrb::COLOR_YELLOW, AmbientOrb::ANIMATION_MEDIUM ],
  [ AmbientOrb::COLOR_ORANGE, AmbientOrb::ANIMATION_FAST ],
  [ AmbientOrb::COLOR_RED,    AmbientOrb::ANIMATION_VERY_FAST ],
].each do |(color, animation)|
  orb.update(color, animation)
  sleep(10)
end
```
