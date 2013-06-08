class Scene_Character < Scene
  attr_accessor :window_menu

  def initialize(window)
    super(window)
    @items = Hash.new
    window.hero.items.each do |item|
      @items[item.name] = item
    end
    @window_menu = Window_Menu.new(@window, 160, @items, 0)
    if not @items.empty?
      @window_menu.active = true
    end
  end
  
  
  def update
    @window_menu.update
  end
  
  def draw
    @window_menu.draw if @window_menu.active?
    @window.font.draw("HP", @window.width-140, 0, 20)
    @window_menu.drawHPBar(@window.width-100, 0, 100, 20, Color.new(255, 0, 255, 0), Color.new(255, 0, 100, 0), @window.hero.hp, 100)
    @window.font.draw("EXP", @window.width-140, 25, 20)
    @window_menu.drawEXPBar(@window.width-100, 25, 100, 20, Color.new(255, 0, 0, 255), Color.new(255, 0, 0, 100), @window.hero.exp, 100)
  end
end