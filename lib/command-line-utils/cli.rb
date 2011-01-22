#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'optparse'
module CommandLineUtils
  class CLI
    def initialize
      @options = Hash.new
      @options[:debug] = false
      @commands = Commands.new
    end

    def dispatch(cmd,cmd_argv)
      @commands.send(cmd)
    end

    def options
      OptionParser.new {|opt|
        opt.on('--version', 'show version') { version;exit }
        opt.on('--help', 'show this message') { usage;exit }
        opt.on('--debug', 'debug mode') { @options[:debug] = true }
      }
    end

    def execute(argv)
      begin
        @opt = options
        cmd_argv = @opt.order!(argv)
        cmd = cmd_argv.shift
        raise "command is not specified" unless cmd
        @commands.options = @options
        @commands.command_options = cmd_argv
        dispatch(cmd,cmd_argv)
      rescue =>e
        puts "Message: #{e}"
        puts ""
        usage unless @options[:debug]
        raise e if @options[:debug]
      end
    end

    def usage(e=nil)
      puts @opt
      puts "\nCommands:\n"
      @commands.commands.each { |c|
        puts "    " + c
      }
    end
    
    def version
      File.open(File.join(File.dirname(__FILE__) ,
                          "..","..","VERSION"),"r") { |file|
        puts file.gets
      }
    end
    
    class << self
      def run(argv)
        self.new.execute(argv)
      end
    end
  end
end
