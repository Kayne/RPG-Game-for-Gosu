include Gosu

class GameWindow < Window
  attr_reader :screen_x
  attr_reader :screen_y
  attr_reader :character
  attr_accessor :scene

  def initialize
    super(640, 480, false)
    self.caption = "Projekt"
    @character = Character.new("Jack", 1)
    @scene = Scene_Intro.new(self)
    @fps = FPSCounter.new(self)
  end
  
  def needs_cursor?; true; end

  def update
    @scene.update
    @fps.update
  end
  
  def draw
    @scene.draw
    @fps.draw
  end

  def button_down(id)
    if id == KbEscape
      close
    end
    if id == KbC
      @scene.player.show_info!
    end
    if id == MsLeft and @scene.kind_of?(Scene_Menu)
      @scene.menu.clicked
    end
  end
end