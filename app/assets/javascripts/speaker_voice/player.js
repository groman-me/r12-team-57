(function(window) {
  window.SpeakerVoice || (window.SpeakerVoice = {});

  SpeakerVoice.Player = function(options) {
    function player(options) {
      options || (options = {});

      this.id = options.id;
      this.url = options.url;
      this.timecode = options.timecode;

      this.running = false;
      this.timestamp = 0;
      this.slide = 0;

      this.slider = this.setupSlider();
      this.soundManager = this.setupSoundManager();
    };

    player.prototype.setupSoundManager = function() {
      var self = this;

      return soundManager.setup({
        url: '/assets/soundmanager2/soundmanager2.swf',
        onready: function() {
          soundManager.createSound({
            id: self.id,
            url: self.url,
            autoLoad: true,
            autoPlay: false,
            volume: 100,
            onload: function() {}
          });
        }
      });
    };

    player.prototype.setupSlider = function() {
      var self = this;

      return new SpeakerVoice.Slider({
        id: self.id,
        onchange: function(payload) {
          if (self.running && (self.slide != payload.number)) {
            self.stop();
          }
        }
      });
    };

    player.prototype.play = function() {
      this.prepare(0);
      this.running = true;
      this.soundManager.play(this.id);
    };

    player.prototype.stop = function() {
      this.running = false;
      this.soundManager.stop(this.id);
    };

    player.prototype.update = function(timestamp, slide) {
      this.timestamp = timestamp;
      this.slide = slide;
    };

    player.prototype.prepare = function(part) {
      var self = this,
          timestamp = this.timecode[part][0],
          slide = this.timecode[part][1];

      self.soundManager.onPosition(self.id, timestamp, function(position) {
        self.update(timestamp, slide);
        self.slider.goto(slide);
        self.prepare(part + 1);
      });
    }

    return player;
  }();
})(window);
