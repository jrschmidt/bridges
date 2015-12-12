// Generated by CoffeeScript 1.9.2
var BridgesApp, ConnectionHelper, LocationFinder, PointsList;

this.mousedown = function(e) {
  var dx, dy, px, py, x, y;
  this.canvas = document.getElementById('bridges-canvas');
  dx = this.canvas.offsetLeft;
  dy = this.canvas.offsetTop;
  px = e.pageX;
  py = e.pageY;
  x = px - dx;
  y = py - dy;
  return alert("click at " + x + ", " + y);
};

BridgesApp = (function() {
  function BridgesApp(base) {
    console.log('BridgesApp constructor called');
    this.canvas = document.getElementById("bridges-canvas");
    this.context = this.canvas.getContext("2d");
    this.context.drawImage(base, 0, 0);
    this.points = new PointsList;
  }

  return BridgesApp;

})();

PointsList = (function() {
  function PointsList() {
    var a, b, i, j, k;
    this.list = [];
    for (b = i = 1; i <= 15; b = ++i) {
      if (b % 2 === 1) {
        for (a = j = 1; j <= 15; a = j += 2) {
          this.list.push([a, b]);
        }
      } else {
        for (a = k = 2; k <= 14; a = k += 2) {
          this.list.push([a, b]);
        }
      }
    }
  }

  return PointsList;

})();

ConnectionHelper = (function() {
  function ConnectionHelper() {
    this.vt = [[0, -2], [-1, -1], [1, -1], [-1, 1], [1, 1], [0, 2]];
    this.hz = [[-1, -1], [1, -1], [-2, 0], [2, 0], [-1, 1], [1, 1]];
  }

  ConnectionHelper.prototype.findConnectors = function(color, a, b) {
    var aa, bb, cnxx, d, deltas, dir, i, len;
    cnxx = [];
    dir = this.findVH(color, a, b);
    if (dir === 'vert') {
      deltas = this.vt;
    } else {
      deltas = this.hz;
    }
    for (i = 0, len = deltas.length; i < len; i++) {
      d = deltas[i];
      aa = a + d[0];
      bb = b + d[1];
      if (aa >= 1 && aa <= 15 && bb >= 1 && bb <= 15) {
        cnxx.push([aa, bb]);
      }
    }
    return cnxx;
  };

  ConnectionHelper.prototype.findVH = function(color, a, b) {
    if (color === 'green') {
      if (a % 2 === 1) {
        return 'vert';
      } else {
        return 'horz';
      }
    } else {
      if (a % 2 === 1) {
        return 'horz';
      } else {
        return 'vert';
      }
    }
  };

  return ConnectionHelper;

})();

LocationFinder = (function() {
  function LocationFinder() {}

  LocationFinder.prototype.find = function(x, y) {
    var a, b;
    a = Math.floor((x - 18) / 25);
    b = Math.floor((y - 18) / 25);
    if ((a + b) % 2 !== 0 || a < 1 || a > 15 || b < 1 || b > 15) {
      return [-1, -1];
    } else {
      return [a, b];
    }
  };

  return LocationFinder;

})();
