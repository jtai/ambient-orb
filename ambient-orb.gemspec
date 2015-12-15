# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

require 'ambient-orb/version'

Gem::Specification.new do |s|
  s.name         = "ambient-orb"
  s.version      = AmbientOrb::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Jon Tai"]
  s.email        = ["jon.tai@gmail.com"]
  s.homepage     = "https://github.com/jtai/ambient-orb"
  s.summary      = "Ruby code to interface with ambientdevices Ambient Orb"
  s.description  = "Only supports the serial interface as ambientdevices' service no longer exists"

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'

  s.add_runtime_dependency 'serialport', '>= 1.3.1'
end
