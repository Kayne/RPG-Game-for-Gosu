class Scene_Character < Scene
  attr_accessor :window_menu

  def initialize(window)
    super(window)
    @background = Image.new(window, "./media/hero_portrait.png", true)
    @items = Hash.new
    window.hero.items.each do |item|
      @items[item.name] = item
    end
    @window_menu = Window_Menu.new(@window, 160, @items, 0)
    if not @items.empty?
      @window_menu.activate
    end
  end
  
  
  def update
    @window_menu.update
  end
  
  def draw
    @background.draw(350, 165, 0)
    @window.font.draw("Press C or Escape to return", 0, 460, 20)
    @window_menu.draw if @window_menu.active?
    @window.font.draw(@window.hero.name, @window.width-140, 0, 20)
    @window.font.draw("HP", @window.width-140, 25, 20)
    @window_menu.drawHPBar(@window.width-100, 25, 100, 20, Color.new(255, 0, 255, 0), Color.new(255, 0, 100, 0), @window.hero.hp, @window.hero.max_hp)
    @window.font.draw("EXP", @window.width-140, 50, 20)
    @window_menu.drawEXPBar(@window.width-100, 50, 100, 20, Color.new(255, 0, 0, 255), Color.new(255, 0, 0, 100), @window.hero.exp, @window.hero.max_exp)
    @window.font.draw("Level: " + @window.hero.level.to_s, @window.width-140, 75, 20)
  end
end