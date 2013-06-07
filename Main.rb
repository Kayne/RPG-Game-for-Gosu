# Load Gosu
require 'gosu'
require 'singleton'

include Gosu

# Load game
require './Settings.rb'
require './Scene.rb'
require './Window.rb'
require './Player.rb'
require './Tileset.rb'
require './Map.rb'
require './Scene_Map.rb'
require './Database.rb'
require './Npc.rb'
require './FPSCounter.rb'
require './Character.rb'
require './Effects.rb'
require './Scene_Intro.rb'
require './Scene_Menu.rb'
require './Audio.rb'
require './Message.rb'
require './Window_Extras.rb'
require './Window_Selectable.rb'
require './Window_Menu.rb'
require './Scene_Character.rb'
require './Timer.rb'

window = GameWindow.new
window.show