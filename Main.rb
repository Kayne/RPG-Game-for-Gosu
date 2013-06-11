# Load Gosu
require 'gosu'
require 'singleton'

include Gosu

# Load game
require './Settings.rb'
require './Scene.rb'
require './Window.rb'
require './Character.rb'
require './Player.rb'
require './Tileset.rb'
require './Map.rb'
require './Scene_Map.rb'
require './Database.rb'
require './Npc.rb'
require './FPSCounter.rb'
require './Hero.rb'
require './Transition.rb'
require './Scene_Intro.rb'
require './Scene_Menu.rb'
require './Audio.rb'
require './Message.rb'
require './Window_Extras.rb'
require './Window_Selectable.rb'
require './Window_Menu.rb'
require './Scene_Character.rb'
require './Timer.rb'
require './Item.rb'

window = GameWindow.new
window.show