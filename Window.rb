include Gosu

class GameWindow < Window
  attr_reader :screen_x
  attr_reader :screen_y
  attr_reader :character
  attr_accessor :scene
  attr_accessor :pause
  attr_accessor :audio
  attr_accessor :message

  def initialize
    super(640, 480, false)
    self.caption = "Projekt"
    @character = Character.new("Jack", 1)
    @audio = Audio.new(self)
    @scene = Scene_Intro.new(self)
    @fps = FPSCounter.new(self)
    @pause = false
    @font = Font.new(self, $config['font_name'], 25)
    @message = Message.new(self)
  end
  
  def needs_cursor?; true; end

  def update
    if @pause == false
      @scene.update
      @fps.update
    end
  end
  
  def draw
    @scene.draw
    @fps.draw if @fps.show_fps?
    if @pause == true
      @font.draw("PAUSE", 220, 220, 20)
    end
    if @message.show?
      @message.show_message
    end
  end

  def button_down(id)
    if @scene.kind_of?(Scene_Character)
      @scene.window_menu.button_down(id)
    end

    if id == KbEscape
      @pause = false
      if @scene.kind_of?(Scene_Map)
        $config['player_x'], $config['player_y'] =  @scene.player.get_actual_position
        $config['player_direccion'] = @scene.player.direccion
        @scene = Transition.new(self, Scene_Menu.new(self), :in, false)

      elsif @scene.kind_of?(Scene_Character)
          @scene = Transition.new(self, Scene_Map.new(self, $config['map'], $config['map_graphic']), :in, false)

      else
        close
      end
    end

    if id == MsLeft and @scene.kind_of?(Scene_Menu)
      @audio.play_sound_effect("accept.ogg")
      @scene.menu.clicked
    end
    if id == KbP
      @pause = (@pause == true) ? false : true
    end
    if id == KbF
      @fps.show_fps = (@fps.show_fps?) ? false : true
    end
    if id == KbC
      if @scene.kind_of?(Scene_Character)
        @scene = Transition.new(self, Scene_Map.new(self, $config['map'], $config['map_graphic']), :in, false)
      else
        $config['player_x'], $config['player_y'] =  @scene.player.get_actual_position
        $config['player_direccion'] = @scene.player.direccion
        @scene = Transition.new(self, Scene_Character.new(self), :in, false)
      end
    end
  end
end