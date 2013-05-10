include Gosu

class Scene_Menu
  attr_accessor :menu

  def initialize(window)
    #@font = Font.new(window, "Verdana", 18)
    @window = window
    @background = Image.new(window, "./media/back.png", true)
    x = @window.width / 2 - 100
    y = @window.height  / 2 - 100
    lineHeight = 50
    items = Array["item", "exit"]
    actions = Array[lambda { @fading = :out }, lambda { @window.close }]
    @menu = Menu.new(@window)
    for i in (0..items.size - 1)
      @menu.add_item(Gosu::Image.new(@window, "./media/menu/#{items[i]}.png", false), x, y, 1, actions[i], Gosu::Image.new(@window, "./media/menu/#{items[i]}_hover.png", false))
      y += lineHeight
    end

    @time = 0
    @fading = :in
    @fade_time = 255
    @color = Color.new(@fade_time, 0, 0 ,0)
  end
  
  def button_down(id)
  end
  
  def update
    @menu.update

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
        @window.scene = Transition.new(@window, Scene_Map.new(@window, $config['map'], $config['map_graphic']), :in, false)#Scene_Title.new(@window)
      else
        @fade_time += 15 # 15 is cool
      end
    end
  end

  def draw
    @background.draw(0,0,0)
    @window.draw_quad(0, 0, @color, 640, 0, @color, 0, 480, @color, 640, 480, @color, 500)   
    @menu.draw
  end
  
end
