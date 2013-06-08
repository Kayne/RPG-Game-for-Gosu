class Scene_Map < Scene
  attr_reader :mapa, :player, :screen_x, :screen_y, :npcs

  def initialize(window, map, tileset)
    super(window)
    @screen_x, @screen_y = 0, 0
    @mapa = Map.new(@window, map, tileset)
    @player = Player.new(@window, @config['player_x'], @config['player_y'])
    @npcs = Array.new
    load_npcs
  end

  def load_npcs
    i = 0
    @mapa.npcs.each do |npc|
      @npcs.push(Npc.new(@window, *Database.load_npcs(npc)))
      if not @config['npcs_position'].nil?
        @npcs.last.x = @config['npcs_position'][i][0]
        @npcs.last.y = @config['npcs_position'][i][1]
      end
      i += 1
    end
  end

  def solid_event_infront?(hero)
    case hero.direccion
      when :left
        for i in 0...@npcs.size
          return true if @npcs[i].solid == true and @npcs[i].x == hero.x - 24 and hero.y >= @npcs[i].y - 20 and hero.y <= @npcs[i].y + 20
        end
        return true if @player.x == hero.x - 24 and hero.y >= @player.y and hero.y <= @player.y + 20
        return false
      when :right
        for i in 0...@npcs.size
          return true if @npcs[i].solid == true and @npcs[i].x == hero.x + 24 and hero.y >= @npcs[i].y - 20 and hero.y <= @npcs[i].y + 20
        end
        return true if @player.x == hero.x + 24 and hero.y >= @player.y - 20 and hero.y <= @player.y + 20
        return false
      when :up
        for i in 0...@npcs.size
          return true if @npcs[i].solid == true and @npcs[i].y == hero.y - 16 and hero.x >= @npcs[i].x - 20 and hero.x <= @npcs[i].x + 20
        end
        return true if @player.y == hero.y - 16 and hero.x >= @player.x - 20 and hero.x <= @player.x + 20
        return false
      when :down
        for i in 0...@npcs.size
          return true if @npcs[i].solid == true and @npcs[i].y == hero.y + 16 and hero.x >= @npcs[i].x - 20 and hero.x <= @npcs[i].x + 20
        end
        return true if @player.y == hero.y + 16 and hero.x >= @player.x - 20 and hero.x <= @player.x + 20
        return false
    end
  end

  def get_solid_event_infront(hero)
    case hero.direccion
      when :left
        for i in 0...@npcs.size
          return @npcs[i] if @npcs[i].solid == true and @npcs[i].x == hero.x - 24 and hero.y >= @npcs[i].y - 20 and hero.y <= @npcs[i].y + 20
        end
      when :right
        for i in 0...@npcs.size
          return @npcs[i] if @npcs[i].solid == true and @npcs[i].x == hero.x + 24 and hero.y >= @npcs[i].y - 20 and hero.y <= @npcs[i].y + 20
        end
      when :up
        for i in 0...@npcs.size
          return @npcs[i] if @npcs[i].solid == true and @npcs[i].y == hero.y - 16 and hero.x >= @npcs[i].x - 20 and hero.x <= @npcs[i].x + 20
        end
      when :down
        for i in 0...@npcs.size
          return @npcs[i] if @npcs[i].solid == true and @npcs[i].y == hero.y + 16 and hero.x >= @npcs[i].x - 20 and hero.x <= @npcs[i].x + 20
        end
    end
  end
  
  def update
    @screen_x = [[@player.x - 320, 0].max, @mapa.width * 32 - 640].min
    @screen_y = [[@player.y - 240, 0].max, @mapa.height * 32 - 480].min
    @npcs.each { |npc| if @player.y > npc.y then npc.z = 2 else npc.z = 4 end; npc.update }
    @player.update
    @mapa.update
  end
  
  def draw
    @player.draw
    @mapa.draw
    @npcs.each { |npc| npc.draw }
  end
end
