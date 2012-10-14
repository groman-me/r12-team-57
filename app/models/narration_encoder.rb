require "sound_encoder"

class NarrationEncoder
  @queue = :sound_encoding

  def self.perform(narration_id)
    narration = Narration.find narration_id
    narration.update_attributes!(state: Narration::STATES[:in_progress])

    wav_path = narration.wav.path
    ext = File.extname(wav_path)
    mp3_file_name = File.basename(wav_path, ext) + '.mp3'
    mp3_file = Tempfile.new(mp3_file_name)
    begin
      SoundEncoder.process wav_path, mp3_file.path
      mp3_file.rewind
      narration.mp3 = mp3_file
      narration.mp3_file_name = mp3_file_name
      narration.state = Narration::STATES[:complete]
      narration.save
    ensure
      mp3_file.close
      mp3_file.unlink
    end
  end
end