(function(window) {
  window.SpeakerVoice || (window.SpeakerVoice = {});

  SpeakerVoice.Slider = function(options) {
    function slider(options) {
      options || (options = {});

      this.iframe = document.getElementById(options.id);
      this.callbacks = {
        onchange: options.onchange || function() {}
      };

      this.bindListeners();
    };

    slider.prototype.bindListeners = function() {
      var self = this;

      window.addEventListener('message', function(message) {
        return self.receive(message);
      });

      this.iframe.addEventListener('load', function() {
        return self.send('setup');
      });
    };

    slider.prototype.receive = function(message) {
      var data = JSON.parse(message.data);
      this.callbacks['on' + data[0]].call(message, data[1]);
    };

    slider.prototype.send = function() {
      var message = (1 <= arguments.length) ? Array.prototype.slice.call(arguments, 0) : [];

      this.iframe.contentWindow.
        postMessage(JSON.stringify(message), 'http://speakerdeck.com');
    };

    slider.prototype.previous = function() {
      return this.send('previousSlide');
    };

    slider.prototype.next = function() {
      return this.send('nextSlide');
    };

    slider.prototype.goto = function(slide) {
      return this.send('goToSlide', slide);
    };

    return slider;
  }();
})(window);
