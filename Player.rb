include Gosu

class Player
  attr_accessor :x
  attr_accessor :y
  attr_accessor :z
  attr_accessor :direccion
  attr_reader :start_x, :start_y
  attr_accessor :window_menu
  def initialize(window, x, y)
    @window = window
    @config = Settings.instance
    @font = Font.new(@window, @config['font_name'], @config['font_size'])

    @x = ((x-1)*32)
    @y = ((y-1)*32)-24
    @z = 3

    @poses = Gosu::Image.load_tiles(@window, @config['character_graphic'], 32, 48, false)
    @pose = @poses[0]
    @direccion = @config['player_direccion']
    @speed = 3

    @window_menu = nil
  end

  def get_actual_position
    [(@x/32+1), ((@y+24)/32+1)]
  end

  def walk
    case @direccion
      when :up
        for i in 0...@speed
          @y -= 1 if not @window.scene.solid_event_infront?(self)
        end
      when :down
        for i in 0...@speed
          @y += 1 if not @window.scene.solid_event_infront?(self)
        end
      when :left
        for i in 0...@speed
          @x -= 1 if not @window.scene.solid_event_infront?(self)
        end
      when :right
        for i in 0...@speed
          @x += 1 if not @window.scene.solid_event_infront?(self)
        end
    end
    return [@x, @y]
  end
  
  def draw
    if @direccion == :left and @window.button_down?(Button::KbLeft)
      if milliseconds / 175 % 4 == 0
        @pose = @poses[4]
      elsif milliseconds / 175 % 4 == 1
        @pose = @poses[5]
      elsif milliseconds / 175 % 4 == 2
        @pose = @poses[6]
      elsif milliseconds / 175 % 4 == 3
        @pose = @poses[7]
      end
    elsif @direccion == :right and @window.button_down?(Button::KbRight)
        if milliseconds / 175 % 4 == 0
          @pose = @poses[8]
        elsif milliseconds / 175 % 4 == 1
          @pose = @poses[9]
        elsif milliseconds / 175 % 4 == 2
          @pose = @poses[10]
        elsif milliseconds / 175 % 4 == 3
          @pose = @poses[11]
        end
    elsif @direccion == :up and @window.button_down?(Button::KbUp)
      if milliseconds / 175 % 4 == 0
          @pose = @poses[12]
        elsif milliseconds / 175 % 4 == 1
          @pose = @poses[13]
        elsif milliseconds / 175 % 4 == 2
          @pose = @poses[14]
        elsif milliseconds / 175 % 4 == 3
          @pose = @poses[15]
        end
    elsif @direccion == :down and @window.button_down?(Button::KbDown)
      if milliseconds / 175 % 4 == 0
          @pose = @poses[0]
        elsif milliseconds / 175 % 4 == 1
          @pose = @poses[1]
        elsif milliseconds / 175 % 4 == 2
          @pose = @poses[2]
        elsif milliseconds / 175 % 4 == 3
          @pose = @poses[3]
        end
    end
    @pose.draw(@x - @window.scene.screen_x,@y - @window.scene.screen_y, @z)
    
    @window_menu.draw if not @window_menu.nil?
  end

  def update

    if @window_menu.nil?
      meet_npc
    else @window_menu.nil?
      @window_menu.update
    end

    @x_pies = @x + (@pose.width/2)
    @y_pies = @y + @pose.height
    if @window.button_down?(Button::KbLeft) and @x > 0 - @window.scene.screen_x
      @direccion = :left
      if not @window.scene.mapa.solid(@x_pies-16, @y_pies) and not @window.scene.solid_event_infront?(self)
        walk
      end
    elsif @window.button_down?(Button::KbRight) and @x < (@window.scene.mapa.width * 32) - @pose.width
      @direccion = :right
      if not @window.scene.mapa.solid(@x_pies+16, @y_pies) and not @window.scene.solid_event_infront?(self)
        walk
      end
    elsif @window.button_down?(Button::KbUp) and @y > 0 - @window.scene.screen_y
      @direccion = :up
      if not @window.scene.mapa.solid(@x_pies, @y_pies-16) and not @window.scene.solid_event_infront?(self)
        walk
      end
    elsif @window.button_down?(Button::KbDown) and @y < (@window.scene.mapa.height * 32) - @pose.height
      @direccion = :down
      if not @window.scene.mapa.solid(@x_pies, @y_pies+6) and not @window.scene.solid_event_infront?(self)
        walk
      end
    else 
      case @direccion
        when :left
          @pose = @poses[4]
        when :right
          @pose = @poses[8]
        when :up
          @pose = @poses[12]
        when :down
          @pose = @poses[0]
      end
    end
    self.draw
  end

  def meet_npc
    if @window.button_down?(Button::KbA) and @window.scene.solid_event_infront?(self)
      @window.pause = true
      npc = @window.scene.get_solid_event_infront(self)
      
      if not npc.nil?

        if npc.commands?
          @window_menu = Window_Menu.new(@window, 160, npc.commands, 0, @window.width/2-80, @window.height/2)
          @window_menu.active = true
        end
      
        npc.play_sound_if_any
        @window.message.message = npc.message
        @window.message.show = true
        @window.timers << Timer.new((npc.commands?) ? 5 : 2, lambda {@window.message.hide_message; @window.scene.player.window_menu = nil; @window.pause = false})
      end
    end
  end

  def save_to_file(filename)
    serialized_object = Marshal::dump(self)
    File.open(@config['save_dir'] + '/' + filename, "w") do |f|
      f.puts serialized_object
    end
  end

  def load_from_file(filename)
    object = nil
    File.open(@config['save_dir'] + '/' + filename, "r").each do |object|
      object = YAML::load(object)
    end
    return object
  end
end