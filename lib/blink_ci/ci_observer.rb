module BlinkCi
  class CiObserver
    include Chicanery

    def initialize(host, user, password)
      @host = host
      @user = user
      @password = password
    end

    def observe
      # without dependency on run_every which hides interrupt events
      # https://github.com/perryn/chicanery/blob/c72f81b6b126e84a7e246697ef63c065e8465585/lib/chicanery.rb (line 31)
      # https://github.com/perryn/blinky/blob/master/lib/ci_server_plugins/cctray_server_plugin.rb
      server Chicanery::Cctray.new 'ci', xml_uri, 
             user: @user, password: @password

      when_run do |current_state|
        building = !current_state[:servers]["ci"].select{|project, info| info[:activity] == :building}.empty?
        if building
          yield :building!, current_state.has_failure?
        else
          current_state.has_failure? ? yield( :failure! ) : yield( :success! )
        end
      end

      begin
        loop {run; sleep 15}
      rescue Interrupt
        yield :switch_off!
        puts "I'm swiching off, bye bye"
        exit 0
      rescue StandardError => e
        yield :warning!
        raise e
      end
    end

    def xml_uri
      "http://#{@host}/cc.xml"
    end

  end
end
