module Rubii
  module Device
    class Keyboard
      attr_reader :arrow_pad
      def initialize
        @arrow_pad = {
          :up => {
            :press   => DeviceEvent.new("/dev/input/event3", [[4, 4, 458834], [1, 103, 1]]),
            :release => DeviceEvent.new("/dev/input/event3", [[4, 4, 458834], [1, 103, 0]])
          },

          :down => {
            :press   => DeviceEvent.new("/dev/input/event3", [[4, 4, 458833], [1, 108, 1]]),
            :release => DeviceEvent.new("/dev/input/event3", [[4, 4, 458833], [1, 108, 0]])
          },

          :left => {
            :press   => DeviceEvent.new("/dev/input/event3", [[4, 4, 458832], [1, 105, 1]]),
            :release => DeviceEvent.new("/dev/input/event3", [[4, 4, 458832], [1, 105, 0]])
          },

          :right => {
            :press   => DeviceEvent.new("/dev/input/event3", [[4, 4, 458831], [1, 106, 1]]),
            :release => DeviceEvent.new("/dev/input/event3", [[4, 4, 458831], [1, 106, 0]])
          }
        }
      end
      
      def self.default
        @default ||= new
      end
    end
    
    class Mouse
      attr_reader :left, :right, :middle, :scroll, :motion
      def initialize
        @left = {
          :press   => DeviceEvent.new("/dev/input/event3", [[4, 4, 589825], [1, 272, 1]]),
          :release => DeviceEvent.new("/dev/input/event3", [[4, 4, 589825], [1, 272, 0]])
        }

        @right = {
          :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
          :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
        }

        @middle = {
          :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
          :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
        }

        @motion = MotionEvent.new("/dev/input/event3", 1, 1)

        @scroll = {
          :left  => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
          :right => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
          :up    => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
          :down  => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
        }
      end
      
      def self.default
        @default ||= new
      end
    end
  end
end
