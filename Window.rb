class GameWindow < Window
  attr_reader :screen_x, :screen_y, :hero
  attr_accessor :scene, :pause, :audio, :message, :timers, :font

  def initialize
    super(640, 480, false)
    self.caption = "Projekt"

    @config = Settings.instance
    Database.load_items
    @hero = Hero.new("Jack", 1, 50, 50, 0)
    @audio = Audio.instance
    @audio.set_window(self)
    @fps = FPSCounter.new(self)
    @font = Font.new(self, @config['font_name'], @config['font_size'])
    @message = Message.new(self)
    @timers = Array.new
    @scene = Scene_Intro.new(self)
    

    @pause = false
  end

  def update
    if not @pause
      @scene.update
      @fps.update
      check_new_level
      check_if_dead
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
        
        save_player_position
        save_npcs_position
        
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
    if id == KbC and not @message.show?
      if @scene.kind_of?(Scene_Character)
        @scene = Transition.new(self, Scene_Map.new(self, @config['map'], @config['map_graphic']), :in, false)
      elsif @scene.kind_of?(Scene_Map)
        save_player_position
        save_npcs_position
        @scene = Transition.new(self, Scene_Character.new(self), :in, false)
      end
    end
  end

  private
  
  def save_npcs_position
    i = 0
    @config['npcs_position'] = Hash.new
    @scene.npcs.each do |npc|
      @config['npcs_position'][i] = [npc.x, npc.y]
      i += 1
    end
  end

  def save_player_position
    @config['player_x'], @config['player_y'] =  @scene.player.get_actual_position
    @config['player_direccion'] = @scene.player.direccion
  end

  def check_timers
    @timers.each { |t| t.update }
    @timers.delete_if { |t| t.finished? }
  end

  def check_new_level
    if @hero.next_level?
      @pause = true
      @hero.next_level
      @message.message = "Zdobyles poziom!"
      @message.show = true
      @timers << Timer.new(2, lambda {@message.hide_message; @scene.player.window_menu = nil; @pause = false})
    end
  end

  def check_if_dead
    if @hero.dead?
      @pause = true
      @hero.next_level
      @message.message = "Niestety, zginales. W tym swiecie wskrzeszanie nie dziala - zegnaj!"
      @message.show = true
      @timers << Timer.new(5, lambda {close})
    end
  end

end