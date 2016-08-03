module Rubii
  class Input
    def sendevent evt

    end

    def sendkey key

    end

    def sendtext txt

    end

    def launch app

    end
  end
  
  class InputDevice
    attr_reader :controller, :driver, :config
    def initialize controller, driver, cfg = Rubii::Config[:default]
      @controller = controller
      @driver     = driver
      @config     = cfg
      
      cfg.each_pair do |n, c|
        c[:digital].each_pair do |v, h|
          [revt = h[:rise],
          fevt = h[:fall]].each do |e| 
            if e.respond_to? :"controller="
              e.controller = controller
            end
          end
          
          controller.components[n].on_rise v do revt.perform(driver) end
          controller.components[n].on_fall v do fevt.perform(driver) end
        end
        
        next unless controller.components[n].respond_to?(:on_change)
        
        if c[:change].respond_to? :controller
          c[:change].controller = controller
        end
        
        controller.components[n].on_change do |*o| 
          c[:change].perform(*[driver].push(*o)) 
        end
      end 
      
      def update
        controller.update
      end
      
      def dump
        controller.dump
      end
      
      def run i=0.111
        loop do
          update
          print "\r"+"#{dump}" if ARGV[2] == "dump"
          sleep i
        end
      end
    end
  end  
end
