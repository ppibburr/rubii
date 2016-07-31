module Rubii
  module AndroidADB
    Config = {
      :default => {
        :buttons = {
          :home  => {
            :press   => KeyEvent.new(AndroidADB::KEYMAP[:HOME]), 
            :release => NullEvent
           },

          :up    => {
            :press   => ArrowPad[:up][:press],
            :release => ArrowPad[:up][:release],
          },

          :down  => {
            :press   => ArrowPad[:down][:press],
            :release => ArrowPad[:down][:release],
          },
          
          :left  => {
            :press   => ArrowPad[:left][:press],
            :release => ArrowPad[:left][:release],
          },

          :right => {
            :press   => ArrowPad[:right][:press],
            :release => ArrowPad[:right][:release],
          },

          :a     => {
            :press   => Mouse[:left][:press],
            :release => Mouse[:left][:release],
          },

          :b     => {
            :press   => :KeyEvent.new(AndroidADB::KEYMAP[:BACK]),
            :release => NullEvent
          },

          :one   => {
            :press   => :KeyEvent.new(AndroidADB::KEYMAP[:PAUSE]),
            :release => NullEvent
          },

          :two   => {
            :press   => :KeyEvent.new(AndroidADB::KEYMAP[:SEARCH]),
            :release => NullEvent
          },

          :plus  => {
            :press   => :KeyEvent.new(AndroidADB::KEYMAP[:ENTER]),
            :release => NullEvent
          },

          :minus => {
            :press   => :KeyEvent.new(AndroidADB::KEYMAP[:APPS]),
            :release => NullEvent
          },

          :c => {
            :press   => NullEvent,
            :release => NullEvent
          },

          :z => {
            :press   => NullEvent,
            :release => NullEvent
          }
        },

        :axi = {
          :acc => {
            :change => NullEvent,

            :digital => {
              :up    => {
                :rise   => ArrowPad[:up][:press],
                :fall   => ArrowPad[:up][:release],
              },

              :down  => {
                :rise   => ArrowPad[:down][:press],
                :fall   => ArrowPad[:down][:release],
              },
          
              :left  => {
                :rise => ArrowPad[:left][:press],
                :fall => ArrowPad[:left][:release],
              },

              :right => {
                :rise => ArrowPad[:right][:press],
                :fall => ArrowPad[:right][:release],
              }
            }
          },

          :ir => {
            :change => Mouse[:motion],

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
    }
  end
end
