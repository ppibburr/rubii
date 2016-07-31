module Rubii
  module Keyboard
    ArrowPad = {
      :up => {
        :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
      },

      :down => {
        :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
      },

      :left => {
        :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
      },

      :right => {
        :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
      },
    }

    Mouse = {
      :left => {
        :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
      },

      :right => {
        :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
      },

      :middle => {
        :press   => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :release => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
      },

      :motion => MotionEvent.new("/dev/input/event3"),

      :scroll => {
        :left  => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :right => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :up    => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]]),
        :down  => DeviceEvent.new("/dev/input/event3", [[0,0,0], [0,0,0]])
      }
    }
end
