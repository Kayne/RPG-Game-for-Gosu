class Scene

  def initialize(window)
    @window = window
    @config = Settings.instance

    @time = 0
    @fading = :in
    @fade_time = 255
    @fade_pause = false
    @color = Color.new(@fade_time, 0, 0 ,0)
  end

  def set_folding(where)
    @where_to_fold = where
  end

  def folding
    @color = Color.new(@fade_time, 0, 0 ,0)
    case @fading
      when :in
        if @fade_time <= 0
          @fading = :wait
        else
          @fade_time -= 15
        end
      when :wait
        if not @fade_pause
          @time += 1
          if @time >= 200
            @fading = :out
            @fade_pause = false
          end
        end
      when :out
        if @fade_time >= 255
          @window.scene = Transition.new(@window, @where_to_fold, :in, false)
        else
          @fade_time += 15
        end
    end
  end
end