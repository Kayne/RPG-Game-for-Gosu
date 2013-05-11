class Audio

  AUDIO_PATH = File.join(File.dirname(__FILE__), $config['audio_path'])
  BGM_PATH   = File.join(AUDIO_PATH, 'music')
  SE_PATH    = File.join(AUDIO_PATH, 'sounds')

  def initialize(window)
    @window = window
    @bgm = {}
    @se = {}
  end

  def preload_music(file)
    @bgm[file] ||= Song.new(@window, File.join(BGM_PATH, file))
  end

  def preload_sound_effect(file)
    @se[file] ||= Sample.new(File.join(SE_PATH, file))
  end

  def play_music(file)
    preload_music(file).play
  end

  def play_sound_effect(file)
    preload_sound_effect(file).play
  end

  def clear
    @bgm.clear
    @se.clear
  end

end