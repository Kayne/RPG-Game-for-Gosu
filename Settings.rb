require 'singleton'

class Settings

  include Singleton

  def initialize
    @config = Hash.new
    @config["character_graphic"] = "media/charasets/hero.png"
    @config["map"] = "./media/maps/Test Map.txt"
    @config["map_graphic"] = "./media/tileset.png"
    @config['save_dir'] = './saves'
    @config['font_size'] = 18
    @config['font_name'] = "Verdana"
    @config['player_x'] = 7
    @config['player_y'] = 3
    @config['player_direccion'] = :down
    @config['audio_path'] = 'media/audio/'
  end

  def [](key)
    @config[key]
  end

  def []=(key, value)
    @config[key] = value
  end

end