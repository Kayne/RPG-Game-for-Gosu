class Window_Menu < Window_Selectable
	attr_accessor :index
	
	def initialize(window,width=192, options={}, index=0, x=0, y=0)
		super(window, width, options.size * 32, 32, index, x, y)
		@options = options
		@font = Font.new(window, @config['font_name'], @config['font_size'])
	end
	
	def draw_commands
		spacing = 32
		for i in 0...@options.size
			position = spacing * i+1
			adjust = @font.text_width(@options.keys[i], 1)
			@font.draw(@options.keys[i], @x+((@width/2)-(adjust/2)), @y+8 + position, @z+1)
		end
	end

	def call(id)
		@options[@options.keys[id]].call
	end
	
	def button_down(id)
		if active?
			if id == KbDown and not @index == @options.size - 1
				@window.audio.play_sound_effect("accept.ogg")
				@index += 1
			end				
			if id == KbUp and not @index == 0
				@window.audio.play_sound_effect("accept.ogg")
				@index -= 1 
			end
			if id == KbReturn
				@window.audio.play_sound_effect("accept.ogg")
				if @window.scene.kind_of?(Scene_Character)
					@window.hero.use_item(@options[@options.keys[@index]])
					if @options[@options.keys[@index]].usable_once?
						delete(@index)
					end
				else
					call(@index)
					deactive if @window.scene.kind_of?(Scene_Map)
				end
			end
		end
	end
	
	def update
		super
		if @options.empty?
			deactive
		end
	end
	
	def draw
		super
		if active?
			self.draw_commands
			self.draw_index
		end
	end
	
	private 

	def delete(id)
		@options.delete(@options.keys[id])
		@height -= 32
		if @index >= 1
			@index -= 1
		else
			@index = 0
		end
	end
end
