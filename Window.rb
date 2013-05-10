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
    @beep = Sample.new("./media/sounds/accept.ogg")
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
      if @scene.kind_of?(Scene_Map)
        @scene = Transition.new(self, Scene_Menu.new(self), :in, false)#Scene_Title.new(@window)
      else
        close
      end
    end
    if id == KbC
      @scene.player.show_info!
    end
    if id == MsLeft and @scene.kind_of?(Scene_Menu)
      @beep.play
      @scene.menu.clicked
    end
  end
end