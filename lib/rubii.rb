begin
  require 'rubygems'
rescue; end

$: << dir=File.expand_path(File.dirname(__FILE__))
$: << File.join(dir, "rubii")

module Rubii
  VERSION = "0.0.0"
  Config  = {}
end

require "rubii/events/base"
require "rubii/input/base"
require "rubii/controller/base"
require "rubii/device/base"
require "rubii/config/defaults"

