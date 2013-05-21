require 'singleton'

class Settings

  include Singleton

  def initialize
    @config = Hash.new

    configs = File.readlines("./database/settings.txt").map { |line| line.chomp }
    0.upto(configs.size-1) do |i|
        temp = configs[i].split(';')
        @config[temp[0]] = eval(temp[1])
      end
    
  end

  def [](key)
    @config[key]
  end

  def []=(key, value)
    @config[key] = value
  end

end