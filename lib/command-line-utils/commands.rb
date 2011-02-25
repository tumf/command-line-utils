#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'optparse'
module CommandLineUtils
  class UsageException < Exception; end
  class Commands
    attr_reader :commands
    attr_accessor :options,:command_options
    def initialize
      @commands = ["help"]
      @help = false
      @summery = ""
      @banner = ""
    end

    def help
      opt = OptionParser.new
      opt.parse!(@command_options)
      @summery = "Show command helps."
      @banner = "command"
      return opt if @help

      @help = true
      command = @command_options.shift
      raise UsageException unless command
      raise "Unknown command: " + command unless commands.include?(command)
      opt = send(command.sub(/:/,"_"))
      puts "Summery: #{@summery}"
      opt.banner += " #{command} #{@banner}" if opt
      puts opt if opt
    end
  end
end

