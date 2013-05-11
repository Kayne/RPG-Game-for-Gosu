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
    @box.drawBox(@window.width/2-100, @window.height/2-100, 200, 200)
    @font.draw(@message, @window.width/2-90, @window.height/2-90, 20)
  end
end