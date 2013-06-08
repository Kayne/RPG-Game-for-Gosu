class Scene

  def initialize(window)
    @window = window
    @config = Settings.instance
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
        @time += 1
        if @time >= 200
          @fading = :out
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