class Character
  attr_reader :name, :level, :max_hp, :hp, :exp

  def initialize(name, level, hp, max_hp, exp)
    @name, @level, @hp, @max_hp, @exp = name, level, hp, max_hp, exp
  end

  def next_level?
    @exp >= @level * 100
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
    @hp <= 0
  end

  def heal hp
    @hp += hp
  end

  def add_exp exp
    @exp += exp
  end

end