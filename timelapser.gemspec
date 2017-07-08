# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "timelapser/version"

Gem::Specification.new do |spec|
  spec.name          = "timelapser"
  spec.version       = Timelapser::VERSION
  spec.authors       = ["Alex Clink"]
  spec.email         = ["code@alexclink.com"]
  spec.platform      = Gem::Platform::CURRENT

  spec.summary       = <<~SUMMARY
    A tool to record a timelapse of your screen on OSX.
  SUMMARY
  spec.description   = <<~DESC
    This gem records your screen in specified intervals and then stitches them together into a video file.
  DESC
  spec.homepage      = "https://alexc.link/software/timelapser"

  spec.files = [
    "lib/**/*",
    "bin/**/*",
    "README.md"
  ].map {|g| Dir.glob(g)}.flatten

  spec.bindir        = "bin"
  spec.executables   = %w[timelapser]
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
end
