module Rubii
  module Input
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
    def initialize cfg = Rubii::Config[:default]
      cfg[:buttons].keys.each_pair do |b, map|
        map.each_pair do |k, evt|
          evt.extend AndroidADB::Input
        end

        buttons.on_press b do
          cfg[:buttons][b][:press].perform
        end

        buttons.on_release b do
          cfg[:buttons][b][:release].perform
        end
      end

      cfg[:axi].keys.each do |a|
        cfg[:axi][a][:change].extend AndroidADB::Input

        axi[a].on_change do |*values|
          evt = cfg[:axi][a][:change]
          evt.perform values[0..evt.method(:perform).arity-1]
        end

        axi[a][:digital].each_pair do |k, dir|
          [dir[:rise], dir[:fall].each do |evt|
            evt.extend AndroidADB::Input
          end
   
          axi[a].on_digital_rise k do
            dir[:rise].perform
          end

          axi[a].on_digital_fall k do
            dir[:fall].perform
          end
        end
      end
    end
  end  
end
