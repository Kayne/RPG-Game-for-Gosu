include Gosu

class Scene_Intro
  def initialize(window)
    #@font = Font.new(window, "Verdana", 18)
    @window = window
    @background = Image.new(window, "./media/background.png", true)
    @time = 0
    @fading = :in
    @fade_time = 255
    @color = Color.new(@fade_time, 0, 0 ,0)
  end
  
  def button_down(id)
  end
  
  def update
    @color = Color.new(@fade_time, 0, 0 ,0)
    case @fading
      
    when :in
      if @fade_time <= 0
        @fading = :wait
      else
        @fade_time -= 15 # 15 is cool
      end
    when :wait
      @time += 1
      if @time >= 200
        @fading = :out
      end
    when :out
      if @fade_time >= 255
        #@window.scene = Transition.new(@window, Scene_Map.new(@window, $config['map'], $config['map_graphic']), :in, false)#Scene_Title.new(@window)
        @window.scene = Transition.new(@window, Scene_Menu.new(@window), :in, false)#Scene_Title.new(@window)
      else
        @fade_time += 15 # 15 is cool
      end
    end
  end
  def draw
    @background.draw(0,0,0)
    @window.draw_quad(0, 0, @color, 640, 0, @color, 0, 480, @color, 640, 480, @color, 500)   
  end
  
end
