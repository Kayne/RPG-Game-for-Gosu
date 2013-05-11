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
  end
end