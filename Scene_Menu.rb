class Scene_Menu < Scene
  attr_accessor :window_menu

  def initialize(window)
    super(window)
    @background = Image.new(window, "./media/back.png", true)
    
    @time = 0
    @fading = :in
    @fade_time = 255
    @color = Color.new(@fade_time, 0, 0 ,0)

    @window_menu = Window_Menu.new(@window, 160, 
      {
      (@config['play'].nil?) ? "New game" : "Continue" => lambda { @fading = :out; @config['play'] = true } ,
      "Save" => lambda { @window.character.save_to_file(Time.new.strftime("%Y-%m-%d_%H-%M")) },
      "Load" => lambda { nil },
      "Exit" => lambda { @window.close }
      }, 
      0, @window.width/2-80, @window.height/2)
    @window_menu.active = true

    set_folding(Scene_Map.new(@window, @config['map'], @config['map_graphic']))
  end
  
  def update
    folding
    @window_menu.update
  end

  def draw
    @background.draw(0,0,0)
    @window.draw_quad(0, 0, @color, 640, 0, @color, 0, 480, @color, 640, 480, @color, 500)   
    @window_menu.draw
  end
  
end
