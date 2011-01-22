require 'helper'
class TestCommandLineUtils < Test::Unit::TestCase
  context "CLI" do
    should "load" do
      assert(CommandLineUtils::CLI.new)
    end
  end
  context "commands" do
    should "load" do
      assert(CommandLineUtils::Commands.new)
    end
  end
end
