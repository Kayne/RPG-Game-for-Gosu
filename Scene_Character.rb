class Scene_Character < Scene
  attr_accessor :window_menu

  def initialize(window)
    super(window)
    @window_menu = Window_Menu.new(@window, 160,
      {
        "Use" => lambda { nil }, 
        "Drop" => lambda { nil },
        "Back" => lambda { @window.scene = Transition.new(@window, Scene_Map.new(@window, @config['map'], @config['map_graphic']), :in, false) }
        }, 0)
    @window_menu.active = true

    @character = @window.character
  end
  
  
  def update
    @window_menu.update

    if @window.button_down?(Button::KbReturn)
      @window_menu.call(@window_menu.index)
    end
  end
  
  def draw
    @window_menu.draw
    @window.font.draw("HP", @window.width-140, 0, 20)
    @window_menu.drawHPBar(@window.width-100, 0, 100, 20, Color.new(255, 0, 255, 0), Color.new(255, 0, 100, 0), @character.hp, 100)
    @window.font.draw("EXP", @window.width-140, 25, 20)
    @window_menu.drawEXPBar(@window.width-100, 25, 100, 20, Color.new(255, 0, 0, 255), Color.new(255, 0, 0, 100), @character.exp, 100)
  end
end