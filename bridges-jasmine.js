// Generated by CoffeeScript 1.9.2
var BridgesApp;

BridgesApp = (function() {
  function BridgesApp(base) {
    console.log('BridgesApp constructor called');
    this.canvas = document.getElementById("bridges-canvas");
    this.context = this.canvas.getContext("2d");
    this.context.drawImage(base, 0, 0);
  }

  return BridgesApp;

})();
