
  module Database
  
    def self.load_items
      $data_items = Array.new
      items = File.readlines("./database/objects.txt").map { |line| line.chomp }
      for i in 0...items.size
        $data_items << items[i].split(';')
      end
    end
    
    def self.load_npcs(npc)
      npc_load = File.readlines("./events/"+npc+".txt").map { |line| line.chomp }
      
      x = npc_load[1]
      x.gsub!('x:', '')
      
      y = npc_load[2]
      y.gsub!('y:', '')
      
      filename = npc_load[3]
      filename.gsub!('filename:', '')
      
      movement = npc_load[4]
      movement.gsub!('movement:', '')
      movement = eval(':'+movement)
      
      face = npc_load[5]
      face.gsub!('face:', '')
      face = eval(':'+face)
      
      solid = npc_load[6]
      solid.gsub!('solid:', '') 
      solid = eval(solid)

      width = npc_load[7]
      width.gsub!('width:', '') 
      width = eval(width)

      height = npc_load[8]
      height.gsub!('height:', '') 
      height = eval(height)

      speed = npc_load[9]
      speed.gsub!('speed:', '') 
      speed = eval(speed)

      sound = npc_load[10]
      sound.gsub!('sound:', '') 

      message = npc_load[11]
      message.gsub!('message:', '')
      
      route = npc_load[12] 
      route.gsub!('route:', '')
      
      comm = []
      for i in 0...npc_load.size
        next if (0...13).include?(i)
        comm.push(npc_load[i]) 
      end
      comm.to_s.gsub!('commands:', '')
      comm.shift
      commands = Hash.new
      comm.each do |str|
        arr = str.split(';;;')
        commands[arr[0]] = arr[1]
      end
      
      return x.to_i,y.to_i,filename,movement,face,solid,width,height,speed,sound,message,route,commands
    end
    
  end