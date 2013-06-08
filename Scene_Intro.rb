class Scene_Intro < Scene
  def initialize(window)
    super(window)
    @background = Image.new(window, "./media/background.png", true)
    @time = 0
    @fading = :in
    @fade_time = 255
    @color = Color.new(@fade_time, 0, 0 ,0)
    @window.audio.play_music("FromHere.ogg")
    set_folding(Scene_Menu.new(@window))
  end
  
  def update
    folding
  end

  def draw
    @background.draw(0,0,0)
    @window.draw_quad(0, 0, @color, 640, 0, @color, 0, 480, @color, 640, 480, @color, 500)   
  end
  
end
