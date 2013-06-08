class Character

  def initialize(window, filename, speed, direccion, width=32, height=48)
    @window = window
    @config = Settings.instance

    @poses = Image.load_tiles(window, "./media/charasets/"+filename+".png", width, height, false) 
    @pose = @poses[0]
    @direccion = direccion
    @speed = speed
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

end