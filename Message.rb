#encoding: utf-8
class Message

  attr_accessor :message
  attr_writer :show

  def initialize(window)
    @window = window

    @show = false
    @message = nil
    @box = Window_Extras.new(@window, 0, 0, 0, 0)
    @box.colors
  end

  def hide_message
    @message = ""
    @show = false
  end

  def show?
    @show
  end

  def show_message
    draw
  end

  def draw
    @box.drawBox(0, @window.height-100, @window.width, 100, 10)
    @window.font.draw(@message, 10, @window.height-90, 20)
  end
end