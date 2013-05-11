class Timer
  
  def initialize(finish, callback)
    @seconds = 0
    @finish = finish
    @finished = false
    @callback = callback
    @last_time = Gosu::milliseconds()
  end

  def finished?
    @finished
  end
  
  def update
    if (Gosu::milliseconds - @last_time) / 1000 == 1
      @seconds += 1
      @last_time = Gosu::milliseconds()
    end
    if @seconds >= @finish
      @callback.call
      @finished = true
    end
  end
end
