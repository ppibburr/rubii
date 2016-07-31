$: << dir=File.expand_path(File.dirname(__FILE__))
$: << File.join(dir, "rubii")

module Rubii
  VERSION = "0.0.0"
  Config  = {}
end

require "ruby/events/base"
require "ruby/input/base"
require "ruby/controller/base"
require "ruby/device/base"
require "ruby/config/defaults"

