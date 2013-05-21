include Gosu

class GameWindow < Window
  attr_reader :screen_x, :screen_y, :character
  attr_accessor :scene, :pause, :audio, :message, :timers, :font

  def initialize
    super(640, 480, false)
    self.caption = "Projekt"

    @config = Settings.instance
    @character = Character.new("Jack", 1, 50, 50, 0)
    @audio = Audio.new(self)
    @fps = FPSCounter.new(self)
    @font = Font.new(self, @config['font_name'], @config['font_size'])
    @message = Message.new(self)
    @timers = Array.new
    @scene = Scene_Intro.new(self)
    

    @pause = false
  end
  
  def needs_cursor?
    true
  end

  def check_timers
    @timers.each { |t| t.update }
    @timers.delete_if { |t| t.finished? }
  end

  def update
    if not @pause
      @scene.update
      @fps.update
    end
    if @pause and not @scene.player.window_menu.nil?
      @scene.player.window_menu.update
    end
    check_timers
  end
  
  def draw
    @scene.draw
    @fps.draw if @fps.show_fps?
    
    if @pause and not @message.show?
      @font.draw("PAUSE", 220, 220, 20)
    end

    if @message.show?
      @message.show_message
    end

  end

  def button_down(id)
    if @scene.kind_of?(Scene_Character) or @scene.kind_of?(Scene_Menu)
      @scene.window_menu.button_down(id)
    end

    if @scene.kind_of?(Scene_Map) and not @scene.player.window_menu.nil?
        @scene.player.window_menu.button_down(id)
    end

    if @message.show? and id == KbA and @scene.player.window_menu.nil?
      @message.hide_message
      @pause = false
    end

    if id == KbEscape
      @pause = false
      if @scene.kind_of?(Scene_Map)
        @config['player_x'], @config['player_y'] =  @scene.player.get_actual_position
        @config['player_direccion'] = @scene.player.direccion
        @scene = Transition.new(self, Scene_Menu.new(self), :in, false)

      elsif @scene.kind_of?(Scene_Character)
          @scene = Transition.new(self, Scene_Map.new(self, @config['map'], @config['map_graphic']), :in, false)

      else
        close
      end
    end

    if id == KbP
      @pause = (@pause == true) ? false : true
    end
    if id == KbF
      @fps.show_fps = (@fps.show_fps?) ? false : true
    end
    if id == KbC
      if @scene.kind_of?(Scene_Character)
        @scene = Transition.new(self, Scene_Map.new(self, @config['map'], @config['map_graphic']), :in, false)
      else
        @config['player_x'], @config['player_y'] =  @scene.player.get_actual_position
        @config['player_direccion'] = @scene.player.direccion
        @scene = Transition.new(self, Scene_Character.new(self), :in, false)
      end
    end
  end
end