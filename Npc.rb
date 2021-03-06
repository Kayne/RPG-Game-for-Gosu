class Npc < Character
  attr_accessor :x, :y, :z, :direction
  attr_reader :solid, :message, :commands

  def initialize(window, x, y, filename, movement=:static, face=:down, solid=true, width=32, height=48, speed=2, sound=nil, message='', route='', commands={})
    
    super(window, filename, speed, direction, width, height)

    @x = (x*32)
    @y = (y*32)-24
    @z = 2
    @movement_type = movement
    @face = face
    @solid = solid
    @route = route
    @commands = commands
    @step = 15
    @musicInstance = nil
    @sound = sound
    @message = message

    eval_commands
  end

  def update_x_and_y(x, y)
    @x, @y = x, y
  end

  def eval_commands
    commands.each { |k, v| commands[k] = eval("lambda { #{v} }") }
  end

  def commands?
    not @commands.nil? and not @commands.empty?
  end

  def play_sound_if_any
    if not @sound.empty? and not @sound.nil?
      if (@musicInstance.nil? or not @musicInstance.playing?)
        @musicInstance = @window.audio.play_sound_effect(@sound)
      end
    end
  end

  def walk
    super
    @step += 1
    return [@x, @y]
  end
  
  def face
    case @movement_type
      when :static
        case @face
          when :left
            @pose = @poses[4]
          when :right
            @pose = @poses[8]
          when :up
            @pose = @poses[12]
          when :down
            @pose = @poses[0]
        end
      
      when :random
        direction = rand(4)
        case direction
          when 0
          @direction = :left
          when 1
          @direction = :right
          when 2
          @direction = :up
          when 3
          @direction = :down
        end
    end
  end
  
  def draw
    if @direction == :left
      if milliseconds / 175 % 4 == 0
        @pose = @poses[4]
      elsif milliseconds / 175 % 4 == 1
        @pose = @poses[5]
      elsif milliseconds / 175 % 4 == 2
        @pose = @poses[6]
      elsif milliseconds / 175 % 4 == 3
        @pose = @poses[7]
      end
    elsif @direction == :right
      if milliseconds / 175 % 4 == 0
        @pose = @poses[8]
      elsif milliseconds / 175 % 4 == 1
        @pose = @poses[9]
      elsif milliseconds / 175 % 4 == 2
        @pose = @poses[10]
      elsif milliseconds / 175 % 4 == 3
        @pose = @poses[11]
      end
    elsif @direction == :up
      if milliseconds / 175 % 4 == 0
        @pose = @poses[12]
      elsif milliseconds / 175 % 4 == 1
        @pose = @poses[13]
      elsif milliseconds / 175 % 4 == 2
        @pose = @poses[14]
      elsif milliseconds / 175 % 4 == 3
        @pose = @poses[15]
      end
    elsif @direction == :down
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
    @pose.draw(@x - @window.scene.screen_x, @y - @window.scene.screen_y, @z)
  end
  
  def update
    @x_pies = @x + (@pose.width/2)
    @y_pies = @y + @pose.height
    if @step >= 15
      face
      @step = 0
    end
    if @direction == :left and not @window.scene.mapa.solid(@x_pies-16, @y_pies) and @x > 0 - @window.scene.screen_x and not @window.scene.solid_event_infront?(self)
      walk
    elsif @direction == :left and @window.scene.mapa.solid(@x_pies-16, @y_pies)  or @window.scene.solid_event_infront?(self)
      face
    elsif @direction == :left and @x <= 0 - @window.scene.screen_x
      face
    end
    if @direction == :right and not @window.scene.mapa.solid(@x_pies+16, @y_pies) and @x < (@window.scene.mapa.width * 32) - @pose.width and not @window.scene.solid_event_infront?(self)
      walk
    elsif @direction == :right and @window.scene.mapa.solid(@x_pies+16, @y_pies)   or @window.scene.solid_event_infront?(self)
      face
    elsif @direction == :right  and @x >= (@window.scene.mapa.width * 32) - @pose.width
      face
    end
    if @direction == :up and not @window.scene.mapa.solid(@x_pies, @y_pies-16) and @y > 0 - @window.scene.screen_y and not @window.scene.solid_event_infront?(self)
      walk
    elsif @direction == :up and @window.scene.mapa.solid(@x_pies, @y_pies-16)  or @window.scene.solid_event_infront?(self)
      face
    elsif @direction == :up and @y <= 0 - @window.scene.screen_y
      face
    end
    if @direction == :down and not @window.scene.mapa.solid(@x_pies, @y_pies+6) and @y < (@window.scene.mapa.height * 32) - @pose.height and not @window.scene.solid_event_infront?(self)
      walk
    elsif @direction == :down and @window.scene.mapa.solid(@x_pies, @y_pies+6)  or @window.scene.solid_event_infront?(self)
      face
    elsif @direction == :down and @y >= (@window.scene.mapa.height * 32) - @pose.height
      face
    end
    case @direction
      when :left
        @pose = @poses[4]
      when :right
        @pose = @poses[8]
      when :up
        @pose = @poses[12]
      when :down
        @pose = @poses[0]
    end
    if @x > @window.scene.screen_x - 32 and @x < @window.scene.screen_x + 640 and @y > @window.scene.screen_y - 32 and @y < @window.scene.screen_y + 480
      self.draw
    end
  end
end