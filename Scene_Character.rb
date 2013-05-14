class Scene_Character
  attr_accessor :window_menu

  def initialize(window)
    @window = window
    @window_menu = Window_Menu.new(@window, 160, ["Use", "Drop", "Back"], 0)
    @window_menu.active = true
  end
  
  
  def update
    @window_menu.update

    if @window.button_down?(Button::KbReturn)
      case @window_menu.index
        when 0
          # Use
        when 1 
          # Drop
        when 2
          # Return
          @window.scene = Transition.new(@window, Scene_Map.new(@window, $config['map'], $config['map_graphic']), :in, false)
      end
    end
  end
  
  def draw
    @window_menu.draw
    @window.font.draw("HP", @window.width-140, 0, 20)
    @window_menu.drawHPBar(@window.width-100, 0, 100, 20, Color.new(255, 0, 255, 0), Color.new(255, 0, 100, 0), 10, 100)
    @window.font.draw("EXP", @window.width-140, 25, 20)
    @window_menu.drawEXPBar(@window.width-100, 25, 100, 20, Color.new(255, 0, 0, 255), Color.new(255, 0, 0, 100), 10, 100)
  end
end