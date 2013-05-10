class Character
  attr_reader :name, :level, :max_hp, :hp, :exp

  def initialize(name, level)
    @name, @level, @hp, @max_hp, @exp = name, level, 100, 100, 0
  end

  def next_level?
    return true if @exp >= @level * 100
    return false
  end

  def next_level
    if next_level?
      @exp = 0
      @level += 1
    end
  end

  def next_level!
    @exp = 0
    @level += 1
  end

  def dead?
    return true if @hp <= 0
    return false
  end

  def heal hp
    @hp += hp
  end

  def add_exp exp
    @exp += exp
  end

end