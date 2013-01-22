require "blink_ci/version"
require "mixlib/cli"
require "chicanery"
require "chicanery/cctray"
require "blink1"

require "blink_ci/blink"
require "blink_ci/ci_observer"

module BlinkCi
  def self.new
    BlinkCi.new
  end

  class BlinkCi

    include Mixlib::CLI

    option :host,
      required: true,
      short: "-h JENKINS URI",
      long: "--host JENKINS URI",
      description: "Jenkins host, ex: jenkins.example.com"

    option :user,
      required: true,
      short: "-n BASIC AUTH user",
      long: "--user BASIC AUTH user",
      description: "Basic authentication: user"

    option :password,
      required: true,
      short: "-p BASIC AUTH PASSWORD",
      long: "--password BASIC AUTH PASSWORD",
      description: "Basic authentication: password"

    def start
      parse_options

      @blink = ::BlinkCi::Blink.new
      @observer = ::BlinkCi::CiObserver.new(@host, @user, @password)

      @observer.observe do |*event|
        @blink.send *event
      end
    end

    def parse_options
      super
      @host = config[:host]
      @user = config[:user]
      @password = config[:password]
    end

  end

end
