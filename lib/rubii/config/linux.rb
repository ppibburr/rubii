require "rubii/keymap/linux_xdotool"

module Rubii
  module Linux
    module XDoTool
      Config = {
        :wiimote => {
          :buttons => {
            :digital => {
              :home  => {
                :rise   => NullEvent, 
                :fall   => NullEvent
               },

              :up    => {
                :rise   => KeyPress.new(Rubii::Linux::XDoTool::KEYMAP[:UP]),
                :fall   => KeyRelease.new(Rubii::Linux::XDoTool::KEYMAP[:UP])
              },

              :down  => {
                :rise   => KeyPress.new(Rubii::Linux::XDoTool::KEYMAP[:DOWN]),
                :fall   => KeyRelease.new(Rubii::Linux::XDoTool::KEYMAP[:DOWN])
              },
          
              :left  => {
                :rise => KeyPress.new(Rubii::Linux::XDoTool::KEYMAP[:LEFT]),
                :fall => KeyRelease.new(Rubii::Linux::XDoTool::KEYMAP[:LEFT])
              },

              :right => {
                :rise => KeyPress.new(Rubii::Linux::XDoTool::KEYMAP[:RIGHT]),
                :fall => KeyRelease.new(Rubii::Linux::XDoTool::KEYMAP[:RIGHT])
              },

              :a     => {
                :rise => Rubii::Linux::XDoTool::MouseButtonPress.new(1),
                :fall => Rubii::Linux::XDoTool::MouseButtonRelease.new(1)
              },

              :b     => {
                :rise   => Rubii::Linux::XDoTool::MouseButtonPress.new(3),
                :fall => Rubii::Linux::XDoTool::MouseButtonRelease.new(3)
              },

              :one   => {
                :rise   => NullEvent,
                :fall => NullEvent
              },

              :two   => {
                :rise   => NullEvent,
                :fall => NullEvent
              },

              :plus  => {
                :rise   => KeySend.new(Linux::XDoTool::KEYMAP[:ENTER]),
                :fall => NullEvent
              },

              :minus => {
                :rise   => NullEvent,
                :fall => NullEvent
              },

              :c => {
                :rise   => NullEvent,
                :fall => NullEvent
              },

              :z => {
                :rise   => NullEvent,
                :fall => NullEvent
              }
            }
          },

          :acc => {
            :change => MouseMoveRel.new,

            :digital => {
              :up    => {
                :rise   => KeyPress.new(Rubii::Linux::XDoTool::KEYMAP[:UP]),
                :fall   => KeyRelease.new(Rubii::Linux::XDoTool::KEYMAP[:UP])
              },

              :down  => {
                :rise   => KeyPress.new(Rubii::Linux::XDoTool::KEYMAP[:DOWN]),
                :fall   => KeyRelease.new(Rubii::Linux::XDoTool::KEYMAP[:DOWN])
              },
          
              :left  => {
                :rise => KeyPress.new(Rubii::Linux::XDoTool::KEYMAP[:LEFT]),
                :fall => KeyRelease.new(Rubii::Linux::XDoTool::KEYMAP[:LEFT])
              },

              :right => {
                :rise => KeyPress.new(Rubii::Linux::XDoTool::KEYMAP[:RIGHT]),
                :fall => KeyRelease.new(Rubii::Linux::XDoTool::KEYMAP[:RIGHT])
              }
            }
          },

          :ir => {
            :change => NullEvent,

            :digital => {
              :up    => {
                :rise   => NullEvent,
                :fall   => NullEvent,
              },

              :down  => {
                :rise   => NullEvent,
                :fall   => NullEvent,
              },
          
              :left  => {
                :rise   => NullEvent,
                :fall   => NullEvent,
              },

              :right => {
                :rise   => NullEvent,
                :fall   => NullEvent,
              }
            }
          },

          :nunchuk => {
            :change => NullEvent,

            :digital => {
              :up    => {
                :rise   => NullEvent,
                :fall   => NullEvent,
              },

              :down  => {
                :rise   => NullEvent,
                :fall   => NullEvent,
              },
          
              :left  => {
                :rise   => NullEvent,
                :fall   => NullEvent,
              },

              :right => {
                :rise   => NullEvent,
                :fall   => NullEvent,
              }
            }
          }
        }
      }
    end
  end
end
