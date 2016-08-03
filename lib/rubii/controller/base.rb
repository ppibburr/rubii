require 'matrix'

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
      
      def dump
        ""
      end
    end

    module Digital
      def initialize *o
        super
        
        @on_rise = {}
        @on_fall = {}
      end
    
      def compare a, b
        a.find_all do |v|
          !b.index(v)
        end.each do |d|
          on_fall d
        end

        b.find_all do |v|
          !a.index(v)
        end.each do |d|
          on_rise d
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

      def on_rise q, &b
        if b
          @on_rise[q] = b
          return
        end
        
        if cb = @on_rise[q]
          cb.call
        end
      end

      def on_fall q, &b
        if b
          @on_fall[q] = b
          return
        end
        
        if cb = @on_fall[q]
          cb.call
        end
      end
      
      def dump
        (super + " high:#{high}").strip
      end

      alias :on_press :on_rise
      alias :on_release :on_fall
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
          amt = amt - trim
          amt = max if max and amt > max
          amt = min if min and amt < min
          @value = amt
        end
      end
      

      attr_reader :axi, :change

      def initialize axi, *o
        super *o
        @values = nil
        @change = []
        @axi = axi
      end
      
      def direction_name d
        return nil unless d.is_a?(Integer)
        return nil if d == 0
        if d < 0
            return [:left, :up, :in][d.abs-1] 
        end
        if d > 0
            return [:right, :down, :out][d.abs-1] 
        end
      end

      def ref
        i = -1
        @ref ||= axi.map do |a| 
          i+=1
          pv = axi.map do 0 end
          pv[i] = 1
            
          Vector[*pv]
        end
      end

      def update
        o = axi.map do |a| a.value || a.normal end
        super

        bool = false
        
        ca = axi.map do 0 end
        values.each_with_index do |v, i|
          axi[i].set_value v
          if axi[i].value != o[i]
            bool = true
            c = o[i] - axi[i].value
            ca[i] = c if c.abs > axi[i].debounce
          end
        end

        @change = ca

        if bool
          on_change
        end
        
        true
      end

      def high
        q = axi.map do |a| a.normal end
        
        acc_vec = begin
          (Vector.elements(values, true) - Vector[*q]).normalize
        rescue
          Vector[0, 0, 0]
        end
        
        i = -1
        axi.map do |a|
          i += 1
          q = acc_vec.inner_product(ref[i])
          if qi=[q < -0.5, q > 0.5].index(true)
            [i+1, (i+1)*-1][qi]
          else
          end
        end.find_all do |q| !!q end
      end
      
      def on_digital_fall d=nil, &b
        super direction_name(d), &b
      end
      
      def on_digital_rise d=nil, &b
        super direction_name(d), &b
      end      

      def on_change &b
        if b
          @on_change = b
          return
        end
        
        @on_change.call *change if @on_change
      end
      
      def values
        @values ||= axi.map do |a| a.normal end
      end
      
      def dump
        super + " raw:#{values} change:#{change}"
      end
    end

    class XYAxis < Axis
      attr_reader :x, :y
      def initialize x, y, *o          
  
        super([Axis::Config.new(:x, *x), Axis::Config.new(:y, *y)], *o)
      end
      
      def update
        return unless super
        @x, @y = axi[0..1].map do |a| a.value end
        true
      end
      
      def dump
        super + " xy:#{[x,y]}"
      end
    end
    
    class XYZAxis < XYAxis
      attr_reader :z
      def initialize x,y,z, *o
        super x,y,*o
        
        axi[2] = Axis::Config.new(:z, *z)
      end
      
      def update
        return unless super
        @z = axi[2].value
        true
      end        
      
      def dump
        super + " z:#{z}"
      end
    end

    class Base
      attr_reader :components
      def initialize components
        @components = components
      end

      def update
        components.map do |n, c| c.update end
      end

      def dump
        components.map do |n, c| "#{n}: " + c.dump end.join(" | ")
      end
    end
  end
end

