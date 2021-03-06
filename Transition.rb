class Transition
	attr_reader :screen_x, :screen_y, :mapa

	def initialize(window, scene, type, map=false)
		@window = window
		@next_scene = scene
		@map = map
		@time = 0
		@fading = type
		@fade_time = 255 if @fading == :in
		@fade_time = 0 if @fading == :out
		@color = Color.new(@fade_time, 0, 0 ,0)
		
		if @map
			@mapa = @next_scene.mapa
			@screen_x = [[@next_scene.hero.x - 320, 0].max, @next_scene.mapa.width * 32 - 640].min
			@screen_y = [[@next_scene.hero.y - 240, 0].max, @next_scene.mapa.height * 32 - 480].min
		end
	end
	
	def update
		@color = Color.new(@fade_time, 0, 0 ,0)
		
		case @fading
			when :in
				if @fade_time <= 0
					@window.scene = @next_scene
				else
					@fade_time -= 15 # 15 is cool
				end
			when :out
				if @fade_time >= 255
					@window.scene = @next_scene
				else
					@fade_time += 15 # 15 is cool
				end
		end
			
		self.draw
	end
	
	def draw
		@window.scene.update
		@window.draw_quad(0, 0, @color, 640, 0, @color, 0, 480, @color, 640, 480, @color, 500)   
	end
	
end


	
	

