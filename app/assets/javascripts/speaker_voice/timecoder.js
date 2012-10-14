(function(window) {
  window.SpeakerVoice || (window.SpeakerVoice = {});

  SpeakerVoice.Timecoder = function() {
    function timecoder() {
      this.running = false;
      this.position  = 0;
      this.timecode  = [];
    };

    timecoder.prototype.start = function() {
      this.position = 0;
      this.timecode = [];
      this.running = true;
    };

    timecoder.prototype.stop = function() {
      this.running = false;
    };

    timecoder.prototype.progress = function(ms) {
      this.position = ms;
    };

    timecoder.prototype.store = function(slide) {
      this.timecode.push([this.position, slide]);
    };

    return timecoder;
  }();
})(window);
