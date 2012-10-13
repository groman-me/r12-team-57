require "sound_encoder"

class NarrationEncoder
  def self.perform(narration_id)
    narration = Narration.find narration_id

    wav_path = narration.wav.path
    mp3_file_name = File.basename(wav_path,'.wav') + '.mp3'
    mp3_file = Tempfile.new(mp3_file_name)
    begin
      SoundEncoder.process wav_path, mp3_file.path
      mp3_file.rewind
      narration.mp3 = mp3_file
      narration.mp3_file_name = mp3_file_name
      narration.save
    ensure
      mp3_file.close
      mp3_file.unlink
    end

  end
end