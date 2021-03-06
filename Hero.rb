class Hero
  attr_reader :name, :level, :max_hp, :hp, :exp, :max_exp, :items

  def initialize(name, level, hp, max_hp, exp)
    @name, @level, @hp, @max_hp, @exp = name, level, hp, max_hp, exp
    @max_exp = 100*@level
    @config = Settings.instance
    @items = Array.new
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
    @hp = @max_hp if @hp > @max_hp
  end

  def damage dmg
    @hp -= dmg
    @hp = 0 if @hp < 0
  end

  def add_exp exp
    @exp += exp
  end

  def add_item(item)
    @items << Item.new(self, item)
  end

  def use_item(item)
    use = @items.index(item)
    @items[use].call
    @items.delete_at(use) if @items[use].usable_once?
  end

  def save_to_file(filename)
    File.open(@config['save_dir'] + '/' + filename, "w") do |file|
      Marshal::dump(self, file)
    end
  end

  def load_from_file(filename)
    object = nil
    File.open(@config['save_dir'] + '/' + filename, "r").each do |object|
      object = Marshal::load(object)
    end
    return object
  end

end