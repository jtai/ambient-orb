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

[
  AmbientOrb::COLOR_RED,
  AmbientOrb::COLOR_ORANGE,
  AmbientOrb::COLOR_YELLOW,
  AmbientOrb::COLOR_GREEN,
  AmbientOrb::COLOR_BLUE,
  AmbientOrb::COLOR_PURPLE,
].each do |color|
  orb.update(color, AmbientOrb::ANIMATION_NONE)
  sleep(3)
end
```
