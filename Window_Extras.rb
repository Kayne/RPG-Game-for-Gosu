
class Window_Extras
	attr_accessor :x
	attr_accessor :y
	attr_accessor :z
	attr_accessor :active
	def initialize(window, x, y, width, height, z = 10)
		@window = window
		if x != 0 then @x = x else @x = 0 end
		@z = z
		if y != 0 then @y = y else @y = 0 end
		if width != 0 then @width = width else @width = 0 end
		if height != 0 then @height = height else @height = 0 end
		@active = false
	end
	
	def colors
		@white = Color.new(255, 255, 255, 255)
		@blueBorder = Color.new(255, 33, 35, 79)
		@blue1 = Color.new(255, 66, 68, 120)
		@blue2 = Color.new(255, 56,58, 110)
		@blue3 = Color.new(255, 40, 41, 81) 
		@blue_text = Color.new(255, 192, 224, 255)
		
		@green_light = Color.new(255, 0, 255, 0)
		@green_dark = Color.new(255, 0, 100, 0)
		@blue_light = Color.new(255, 0, 0, 255)
		@blue_dark = Color.new(255, 0, 0, 100)
		@black = Color.new(255, 0, 0, 0)
		@grey = Color.new(255, 50, 50, 50)
	end
	
	def drawBox(x, y, w, h, z = 1)  
		# blue border
		@window.draw_quad(x, y, @blueBorder, x + w, y, @blueBorder, x, y + h, @blueBorder, x + w, y + h, @blueBorder, z)     
		# white border
		@window.draw_quad(x + 1, y + 1, @white, x + w - 1, y + 1, @white, x + 1, y + h - 1, @white, x + w - 1, y + h - 1, @white, z)    
		# blue gradient
		@window.draw_quad(x + 3, y + 3, @blue1, x + w - 3, y + 3, @blue2, x + 3, y + h - 3, @blue2, x + w - 3, y + h - 3, @blue3, z) 
	end

	def drawHPBar(x, y, w, h, color1, color2, hp, max_hp, z=1)  
		# white border
		@window.draw_quad(x, y, @white, x + w, y, @white, x, y + h, @white, x + w, y + h, @white, z)    
		@window.draw_quad(x + 1, y + 1, @black, x + w - 1, y + 1, @black, x + 1, y + h - 1, @black, x + w - 1, y + h - 1, @black, z)   
		# gradient
		pre = (hp*w)/100
		lenght = (pre * 100) / max_hp
		@window.draw_quad(x + 1, y + 1, color1, x + lenght - 1, y + 1, color1, x + 1, y + h - 1, color2, x + lenght - 1, y + h - 1, color2, z) 
	end

	def drawEXPBar(x, y, w, h, color1, color2, exp, max_exp, z=1)  
		# white border
		@window.draw_quad(x, y, @white, x + w, y, @white, x, y + h, @white, x + w, y + h, @white, z)    
		@window.draw_quad(x + 1, y + 1, @black, x + w - 1, y + 1, @black, x + 1, y + h - 1, @black, x + w - 1, y + h - 1, @black, z)    
		# gradient
		pre = (exp*w)/100
		lenght = (pre * 100) / max_exp
		@window.draw_quad(x + 1, y + 1, color1, x + lenght - 1, y + 1, color1, x + 1, y + h - 1, color2, x + lenght - 1, y + h - 1, color2, z) 
	end

end
