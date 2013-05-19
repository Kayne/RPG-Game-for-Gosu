include Gosu

class Scene_Menu
  attr_accessor :window_menu

  def initialize(window)
    #@font = Font.new(window, "Verdana", 18)
    @window = window
    @background = Image.new(window, "./media/back.png", true)
    

    @time = 0
    @fading = :in
    @fade_time = 255
    @color = Color.new(@fade_time, 0, 0 ,0)

    @window_menu = Window_Menu.new(@window, 160, ["New game", "Save", "Load", "Exit"], 0, @window.width/2-80, @window.height/2)
    @window_menu.active = true
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
    when :out
      if @fade_time >= 255
        @window.scene = Transition.new(@window, Scene_Map.new(@window, $config['map'], $config['map_graphic']), :in, false)
      else
        @fade_time += 15 # 15 is cool
      end
    end

    @window_menu.update

    if @window.button_down?(Button::KbReturn)
      case @window_menu.index
        when 0
          @window.scene = Transition.new(@window, Scene_Map.new(@window, $config['map'], $config['map_graphic']), :in, false)
        when 1
          @window.character.save_to_file(Time.new.strftime("%Y-%m-%d_%H-%M"))
        when 2
        when 3
          @window.close
      end
    end
  end

  def draw
    @background.draw(0,0,0)
    @window.draw_quad(0, 0, @color, 640, 0, @color, 0, 480, @color, 640, 480, @color, 500)   
    @window_menu.draw
  end
  
end
