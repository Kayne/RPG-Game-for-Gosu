
class Window_Menu < Window_Selectable
	attr_accessor :index
	
	def initialize(window,width=192, options=[], index=0)
		super(window, width, options.size * 32, 32, index)
		@commands = options
		@font = Font.new(window, $config['font_name'], $config['font_size'])
	end
	
	def draw_commands
		spacing = 32
		for i in 0...@commands.size
			position = spacing * i+1
			adjust = @font.text_width(@commands[i], 1)
			@font.draw(@commands[i], @x+((@width/2)-(adjust/2)), @y+8 + position, @z+1)
		end
	end
	
	def button_down(id)
		if id == KbDown and not @index == @commands.size - 1
			@window.audio.play_sound_effect("accept.ogg")
			@index += 1
		end				
		if id == KbUp and not @index == 0
			@window.audio.play_sound_effect("accept.ogg")
			@index -= 1 
		end
	end
	
	def update
		super
	end
	
	def draw
		super
		self.draw_commands
		self.draw_index if @active == true
		@font.draw("HP", @window.width-140, 0, 20)
		self.drawHPBar(@window.width-100, 0, 100, 20, @green_light, @green_dark, 10, 100)
		@font.draw("EXP", @window.width-140, 25, 20)
		self.drawEXPBar(@window.width-100, 25, 100, 20, @blue_light, @blue_dark, 10, 100)
	end
	
end
