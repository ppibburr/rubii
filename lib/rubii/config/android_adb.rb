require "rubii/keymap/android_adb"

module Rubii
  module AndroidADB
    class WiiIRMouseMotionEvent < Rubii::MotionEvent
      attr_accessor :controller
      attr_reader :btn_1
       
      def initialize btn_1, *o
        @btn_1 = btn_1
        super *o
      end
      
      def perform driver=@driver, x=@x, y=@y, *o
        if controller
          if btn_1 and controller and controller.components[:buttons].high.index(btn_1)
            return unless x.abs > 12 or y.abs > 12
          end
        end
        
        super
      end
    end
  
    Config = {
      :wiimote => {
        :buttons => {
          :digital => {
            :home  => {
              :rise => KeyEvent.new(AndroidADB::KEYMAP[:HOME]), 
              :fall => NullEvent
             },

            :right    => {
              :rise => Rubii::Device::Keyboard.default.arrow_pad[:up][:press],
              :fall => Rubii::Device::Keyboard.default.arrow_pad[:up][:release],
            },

            :left  => {
              :rise => Rubii::Device::Keyboard.default.arrow_pad[:down][:press],
              :fall => Rubii::Device::Keyboard.default.arrow_pad[:down][:release],
            },
            
            :up  => {
              :rise => Rubii::Device::Keyboard.default.arrow_pad[:left][:press],
              :fall => Rubii::Device::Keyboard.default.arrow_pad[:left][:release],
            },

            :down => {
              :rise => Rubii::Device::Keyboard.default.arrow_pad[:right][:press],
              :fall => Rubii::Device::Keyboard.default.arrow_pad[:right][:release],
            },

            :a     => {
              :rise => Rubii::Device::Mouse.default.left[:press],
              :fall => Rubii::Device::Mouse.default.left[:release],
            },

            :b     => {
              :rise => KeyEvent.new(AndroidADB::KEYMAP[:BACK]),
              :fall => NullEvent
            },

            :one   => {
              :rise => DeviceEvent.new("/dev/input/event3",[[4, 4, 786637], [1, 164, 1]]),
              :fall => DeviceEvent.new("/dev/input/event3",[[4, 4, 786637], [1, 164, 0]])
            },

            :two   => {
              :rise => DeviceEvent.new("/dev/input/event3",[[4, 4, 458792], [1, 28, 1]]),
              :fall => DeviceEvent.new("/dev/input/event3",[[4, 4, 458792], [1, 28, 0]])
            },

            :plus  => {
              :rise => DeviceEvent.new("/dev/input/event3",[[4, 4, 786665], [1, 115, 1]]),
              :fall => DeviceEvent.new("/dev/input/event3",[[4, 4, 786665], [1, 115, 0]])
            },

            :minus => {
              :rise => DeviceEvent.new("/dev/input/event3",[[4, 4, 786666], [1, 114, 1]]),
              :fall => DeviceEvent.new("/dev/input/event3",[[4, 4, 786666], [1, 114, 0]])
            },

            :c => {
              :rise => NullEvent,
              :fall => NullEvent
            },

            :z => {
              :rise => NullEvent,
              :fall => NullEvent
            }
          }
        },

        :acc => {
          :change => NullEvent,

          :digital => {
            :up    => {
              :rise => NullEvent, #,Rubii::Device::Keyboard.default.arrow_pad[:up][:press],
              :fall => NullEvent #,Rubii::Device::Keyboard.default.arrow_pad[:up][:release],
            },

            :down  => {
              :rise => NullEvent, #Rubii::Device::Keyboard.default.arrow_pad[:down][:press],
              :fall => NullEvent #Rubii::Device::Keyboard.default.arrow_pad[:down][:release],
            },
        
            :left  => {
              :rise => NullEvent, #Rubii::Device::Keyboard.default.arrow_pad[:left][:press],
              :fall => NullEvent #Rubii::Device::Keyboard.default.arrow_pad[:left][:release],
            },

            :right => {
              :rise => NullEvent, #Rubii::Device::Keyboard.default.arrow_pad[:right][:press],
              :fall => NullEvent #Rubii::Device::Keyboard.default.arrow_pad[:right][:release],
            }
          }
        },

        :ir => {
          :change => WiiIRMouseMotionEvent.new(:a, "/dev/input/event3", 1.92, -1.44),

          :digital => {
            :up    => {
              :rise => NullEvent,
              :fall => NullEvent,
            },

            :down  => {
              :rise => NullEvent,
              :fall => NullEvent,
            },
        
            :left  => {
              :rise => NullEvent,
              :fall => NullEvent,
            },

            :right => {
              :rise => NullEvent,
              :fall => NullEvent,
            }
          }
        },

        :nunchuk => {
          :change => NullEvent,

          :digital => {
            :up    => {
              :rise => NullEvent,
              :fall => NullEvent,
            },

            :down  => {
              :rise => NullEvent,
              :fall => NullEvent,
            },
        
            :left  => {
              :rise => NullEvent,
              :fall => NullEvent,
            },

            :right => {
              :rise => NullEvent,
              :fall => NullEvent,
            }
          }
        }
      }
    }
  end
end
