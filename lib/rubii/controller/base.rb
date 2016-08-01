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
        attr_accessor :min, :max, :trim, :debounce
        def initialize name, min, max, trim, debounce, value=0
          @name, @min, @max, @trim, @debounce = name, min, max, trim, debounce
        end 

        def set_value amt
          @value = amt
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

          v = axi[i].trim
          v = axi[i].max if v > axi[i].max
          v = axi[i].min if v < axi[i].min
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

