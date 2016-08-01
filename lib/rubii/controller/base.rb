module Rubii
  module Controller
    class Component
      attr_accessor :update_rate
      attr_reader :values, :controller

      def initialize controller, update_rate=-1
        @controller = controller
        @update_rate = update_rate
        @values      = []
      end

      def update
        @values = read
        return true
      end

      def read
        []
      end
    end

    module Digital
      def compare a, b
        a.find_all do |v|
          !b.index(v)
        end.each do |d|
          on_release d
        end

        b.find_all do |v|
          !a.index(v)
        end.each do |d|
          on_press d
        end
      end

      def high
        values
      end

      def update
        a = high
        return unless super()
        b = high
        
        compare a, b
        
        return true
      end

      def on_digital_rise q, &b

      end

      def on_digital_fall q, &b

      end

      alias :on_press :on_digital_rise
      alias :on_release :on_digital_fall
    end

    class Buttons < Component
      include Digital

      attr_reader :down
    end

    class Axis < Component
      include Digital

      class Config
        attr_reader :name, :value
        attr_accessor :min, :max, :trim, :debounce, :normal
        def initialize name, normal=0, min=nil, max=nil, trim=0, debounce=0, value=0
          @name, @normal, @min, @max, @trim, @debounce = name, normal, min, max, trim, debounce
        end 

        def set_value amt
          amt = axi[i].max if max and v > max
          amt = axi[i].min if min and v < min
          @value = amt
        end
      end
      
      class XYAxis < Axis
        attr_reader :x, :y, :ref_up, :ref_down
        def initialize x, y, *o
          @ref_up   = Vector[0,-1,0]
          @ref_left = Vector[1,0,0]
          
          i = -1
          super *[x, y].map do |av| i+=1; Config.new([:x,:y][i], *[x,y][i]) end.push(*o)
        end
        
        def update
          return unless super
          @x, @y = axi[0..1].map do |a| a.value end
          true
        end
      end
      
      class XYZAxis < XYAxis
        attr_reader :z, :ref_in, :ref_out
        def initialize x,y,z *o
          super x,y,*o
          
          @ref_in   = Vector[0,-1,0]
          @ref_out  = Vector[1,0,0]
          
          axi[2] = Config.new(:z, *z)
        end
        
        def update
          return unless super
          @z = axi[2]
          true
        end        
      end

      attr_reader axi, :change

      def initialize axi, *o
        super *o
        @axi = axi
      end
      
      def read
        super
        
        i = -1

        @values = values.map do |v|
          i+=1

          v = v - axi[i].trim
        end  
      end

      def update
        o = axi.map do |a| a.value end
        super
         
        bool = false
        
        ca = axi.map do 0 end
        values.each_with_index do |v, i|
          axi[i].set_value v
          if axi[i].value != o[i]
            bool = true
            ca[i] = o[i] - axi[i].value
          end
        end

        if bool
          on_change
        end
      end

      def high
        acc_vec = (Vector.elements(values, true) - Vector[*axi.map do |a| a.normal end]).normalize
        vert    = acc_vec.inner_product @ref_up
        horiz   = acc_vec.inner_product @ref_left
        
        a = []
        
        if vert < -0.5
          a << :down
        elsif vert > 0.5
          a << :up
        end
        
        if horiz < -0.5
          a << :left
        elsif horiz > 0.5
          a << :right
        end        
        a
      end

      def on_change &b
        @on_change.call *change
      end
    end

    class Base
      attr_reader :buttons, :axi
      def initialize
        @buttons = nil
        @axi     = {}
      end

      def update
        @buttons.update
        @axi.each_pair do |a, c| c.update end
      end

      def dump
        "#{self}\n  "+[buttons.dump].push(*axi.map do |n, a| ({n => a.dump}.to_s) end).join("\n  ")
      end
    end
  end
end

