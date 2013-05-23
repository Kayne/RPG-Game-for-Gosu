class Item
  attr_reader :name, :description

  def initialize(character, item)
    @character = character
    @name, @action, @description, @usable_once = item[1], eval("lambda { #{item[4]} }"), item[2], item[3]
  end

  def call
    @action.call
  end

  def usable_once?
    @usable_once
  end

end