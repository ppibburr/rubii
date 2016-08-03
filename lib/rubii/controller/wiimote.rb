require 'cwiid'
module Rubii
  module Controller
    class WiiMote < Rubii::Controller::Base
      class Led < Rubii::Controller::Component
        def set i
          controller.wiimote.led = i
        end
 
        def get
          controller.state.led
        end
        
        def values
          get
        end
 
        def blink hi=15, lo=0, rate=0.25
          bool = true
          @blink = rate
          Thread.abort_on_exception = true
          @thread ||= Thread.new do
            loop do
              set hi if bool
              set lo if !bool
              bool = !bool
              sleep @blink
            end
          end
        end
        
        def dump 
          "#{get}"
        end
      end

      class Buttons < ::Rubii::Controller::Buttons
        BUTTONS = {
          :HOME  => ::WiiMote::BTN_HOME,
          :B     => ::WiiMote::BTN_B,
          :A     => ::WiiMote::BTN_A,
          :ONE   => ::WiiMote::BTN_1,
          :TWO   => ::WiiMote::BTN_2,
          :PLUS  => ::WiiMote::BTN_PLUS,
          :MINUS => ::WiiMote::BTN_MINUS,
          :POWER => nil,
          :UP    => ::WiiMote::BTN_UP,
          :LEFT  => ::WiiMote::BTN_LEFT,
          :RIGHT => ::WiiMote::BTN_RIGHT,
          :DOWN  => ::WiiMote::BTN_DOWN
        }
        
        def initialize *o
          super
        end
        
        def read
          a = [
            (controller.state.buttons & BUTTONS[:HOME] > 0) ? :home : nil,
            (controller.state.buttons & BUTTONS[:PLUS] > 0) ? :plus : nil,
            (controller.state.buttons & BUTTONS[:MINUS] > 0) ? :minus : nil,
            (controller.state.buttons & BUTTONS[:A] > 0) ? :a : nil,
            (controller.state.buttons & BUTTONS[:B] > 0) ? :b : nil,
            (controller.state.buttons & BUTTONS[:ONE] > 0) ? :one : nil,
            (controller.state.buttons & BUTTONS[:TWO] > 0) ? :two : nil,
            (controller.state.buttons & BUTTONS[:UP] > 0) ? :up : nil,
            (controller.state.buttons & BUTTONS[:DOWN] > 0) ? :down : nil,
            (controller.state.buttons & BUTTONS[:LEFT] > 0) ? :left : nil,
            (controller.state.buttons & BUTTONS[:RIGHT] > 0) ? :right : nil
          ].find_all do |q| !!q end
        
          @values = a
        end
      end

      class Acc < XYZAxis
        def initialize controller, update_rate = -1
          super [125, -21,21,127,1], [125, -21,21,130,1], [125, 2,48,100,1], controller, update_rate
          @values = axi.map do |a| a.normal end
        end

        def high
          a = super
          
          # Invert Y
          a[1] = a[1] * -1 if a[1]
          
          names = {
            1 => :left,
            -1  => :right,
            2 => :up,
            -2  => :down,
            -3 => :nz,
            3  => :pz
          }
          
          a.map do |q| names[q] end
        end
         
        def read
          @values = controller.state.acc || @values || [0,0,0]
        end
      end

      # Size reported as 'z'
      class IR < XYZAxis
        def initialize controller, update_rate = -1
          super [0, 0,1000,0,1], [0, 0,747,0,1], [0, nil,nil, 0, 0], controller, update_rate
        end
        
        def read
          @values = controller.state.ir[0] || @values || [0,0,0]
        end
      end

      class Nunchuk < XYZAxis
        def initialize controller, update_rate = -1
          super [125, 2,48,100,1], [125, 2,48,100,1], [125, 2,48,100,1], controller, update_rate
        end
        
        def read
          return
          @values = controller.state.nunchuk || @values || [0,0,0]
        end
      end

      attr_reader :wiimote, :state
      def initialize rpt_mode = ::WiiMote::RPT_ACC | ::WiiMote::RPT_BTN | ::WiiMote::RPT_IR
        puts "Press 1+2 or sync..."
        @wiimote = ::WiiMote.new()
        wiimote.rpt_mode = rpt_mode
        
        super({
          :buttons => Buttons.new(self),
          :led     => Led.new(self),
          :acc     => Acc.new(self),
          :ir      => IR.new(self),
          :nunchuk => Nunchuk.new(self)
        })
      end

      def update
        wiimote.request_status
        @state = wiimote.get_state
        super
      end
      
      def dump
        super
      end
    end
  end
end
