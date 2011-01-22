#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'optparse'
module CommandLineUtils
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
      raise "Unknown command: " + command unless commands.include?(command)
      opt = send(command)
      puts "Summery: #{@summery}"
      opt.banner += " #{command} #{@banner}"
      puts opt
    end
  end
end

