#encoding: utf-8
class Message

  attr_accessor :message
  attr_writer :show

  def initialize(window)
    @window = window
    @font = Font.new(@window, $config['font_name'], $config['font_size'])

    @show = false
    @message = nil
    @box = Window_Extras.new(@window, 0, 0, 0, 0)
    @box.colors
  end

  def show?
    @show
  end

  def show_message
    draw
  end

  def draw
    @box.drawBox(0, @window.height-100, @window.width, 100, 10)
    @font.draw(@message, 10, @window.height-90, 20)
  end
end