class SoundEncoder
  def self.process(wav_path, mp3_path)
    if system('lame', wav_path, mp3_path) && $?.exitstatus == 0
      mp3_path
    else
      raise 'Error in encoding process'
    end
  end
end