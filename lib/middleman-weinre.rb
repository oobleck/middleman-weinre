# Weinre Extension
# TODO: Auto-inject weinre marku?
# NOTE: Breaks /__middleman/config/ ?
# Drop <%= weinre_include_tag %> in your template where you want Weinre inserted
require "middleman-core"

if false
  module Middleman
    module Weinre
      class << self
        attr_reader :app
        def options
          @@options
        end

        def registered(app, options_hash={}, &block)
          defaults = {
            :port => 8080,
            :hostname => nil,
            :bin => '/usr/locale/bin/weinre'
          }
          @@options = defaults.merge(options_hash)
          app.ready do
            if :environment != :build
              require 'socket'
              hostname = @@options[:hostname] || UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
              if !@@options[:bin].blank?
                wnr = fork do
                  exec "#{$WEINRE_BIN} --httpPort #{@@options[:port]} --boundHost #{hostname} &>/dev/null"
                end
                Process.detach(wnr)
                puts "== Weinre is running at http://#{hostname}:#{@@options[:port]}"
                # puts "== Weinre remote debugging is at http://#{hostname}:#{@@options[:port]}/client/#anonymous"
              else
                puts "== Winre was not found on your system. Could not auto-start it for you. :("
                puts "==   Type 'weinre' in a separate terminal to start the server"
              end
              # app.set :weinre_hostname, hostname
              # app.set :weinre_port, options_hash[:port]
              # app.set :weinre_bin, options_hash[:bin]
            else
              # Nothing
            end
          end
          app.send :include, Helpers
        end

        alias :included :registered
      end

      module Helpers
        def weinre_include_tag
          "<script src=\"//#{config[:weinre_hostname]}:#{config[:weinre_port]}/target/target-script-min.js#anonymous\" defer></script>"
        end
      end

    end
  end
else
  class Weinre < Middleman::Extension
    option :bin, nil, 'The weinre binary'
    option :hostname, nil, 'hostname for weinre to use'
    option :port, 8080, 'Port for weinre to use'

    def initialize(app, options_hash={}, &block)
      super
      # app.extend WeinreMethods
      app.ready do
        if :environment != :build
          require 'socket'
          hostname = options_hash[:hostname] || UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
          if !options_hash[:bin].blank?
            wnr = fork do
              exec "#{$WEINRE_BIN} --httpPort #{options_hash[:port]} --boundHost #{hostname} &>/dev/null"
            end
            Process.detach(wnr)
            puts "== Weinre is running at http://#{hostname}:#{options_hash[:port]}"
            # puts "== Weinre remote debugging is at http://#{hostname}:#{options_hash[:port]}/client/#anonymous"
          else
            puts "== Winre was not found on your system. Could not auto-start it for you. :("
            puts "==   Type 'weinre' in a separate terminal to start the server"
          end
          app.set :weinre_hostname, hostname
          app.set :weinre_port, options_hash[:port]
          app.set :weinre_bin, options_hash[:bin]
        else
          # Nothing
        end
      end
    end

    helpers do
      def weinre_include_tag
        "<script src=\"//#{config[:weinre_hostname]}:#{config[:weinre_port]}/target/target-script-min.js#anonymous\" defer></script>"
      end
    end
  end
  ::Middleman::Extensions.register(:weinre, Weinre)
end
