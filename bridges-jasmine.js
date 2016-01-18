// Generated by CoffeeScript 1.9.2
var AiPlayer, BoardGeometryHelper, BridgeDraw, BridgesApp, ConnectionHelper, GameStatus, PointsList;

BridgesApp = (function() {
  function BridgesApp(base) {
    console.log('BridgesApp constructor called');
    this.canvas = document.getElementById("bridges-canvas");
    this.context = this.canvas.getContext("2d");
    this.context.drawImage(base, 0, 0);
    this.boardHelper = new BoardGeometryHelper;
    this.points = new PointsList;
    this.bridgeDraw = new BridgeDraw(this.context, this.boardHelper);
    this.status = new GameStatus(this.boardHelper, this.points);
    this.redAI = new AiPlayer('red', this.points);
    this.playerToMove = 'green';
  }

  BridgesApp.prototype.handleClick = function(xx, yy) {
    var ab, redMove;
    if (this.playerToMove === 'green') {
      console.log("BridgesApp.handleClick(" + xx + ", " + yy + ")");
      ab = this.boardHelper.getAB(xx, yy);
      if (ab[0] >= 0) {
        if (this.status.legalMove(this.playerToMove, ab[0], ab[1])) {
          console.log("(" + xx + ", " + yy + ") --> (" + ab[0] + ", " + ab[1] + ")");
          this.status.makeMove(this.playerToMove, ab[0], ab[1]);
          this.bridgeDraw.drawBridge(this.playerToMove, ab[0], ab[1]);
          this.playerToMove = 'red';
          redMove = this.redAI.move();
          this.bridgeDraw.drawBridge(this.playerToMove, redMove[0], redMove[1]);
          return this.playerToMove = 'green';
        }
      }
    }
  };

  return BridgesApp;

})();

GameStatus = (function() {
  function GameStatus(helper, points) {
    this.helper = helper;
    this.points = points;
    this.connect = new ConnectionHelper(this.helper);
    this.mode = 'active';
  }

  GameStatus.prototype.makeMove = function(color, a, b) {
    console.log("makeMove(" + color + ", " + a + ", " + b + ")");
    return this.points.remove(a, b);
  };

  GameStatus.prototype.legalMove = function(color, a, b) {
    if (this.points.listContains(a, b)) {
      return true;
    } else {
      return false;
    }
  };

  return GameStatus;

})();

AiPlayer = (function() {
  function AiPlayer(color, points) {
    this.color = color;
    this.points = points;
  }

  AiPlayer.prototype.move = function() {
    return this.points.randomPoint();
  };

  return AiPlayer;

})();

PointsList = (function() {
  function PointsList() {
    var a, b, j, k, l;
    this.list = [];
    this.flatlist = [];
    for (b = j = 1; j <= 15; b = ++j) {
      if (b % 2 === 1) {
        for (a = k = 1; k <= 15; a = k += 2) {
          this.list.push([a, b]);
          this.flatlist.push(a * 100 + b);
        }
      } else {
        for (a = l = 2; l <= 14; a = l += 2) {
          this.list.push([a, b]);
          this.flatlist.push(a * 100 + b);
        }
      }
    }
  }

  PointsList.prototype.listContains = function(a, b) {
    if (this.flatlist.indexOf(a * 100 + b) < 0) {
      return false;
    } else {
      return true;
    }
  };

  PointsList.prototype.randomPoint = function() {
    var ab, i;
    i = Math.floor(Math.random() * (this.list.length - 1));
    console.log("i = " + i);
    ab = this.list[i];
    console.log("ab = [" + ab[0] + "," + ab[1] + "]");
    this.iRemove(i);
    return ab;
  };

  PointsList.prototype.remove = function(a, b) {
    var i;
    i = this.flatlist.indexOf(100 * a + b);
    if (i >= 0) {
      return this.iRemove(i);
    }
  };

  PointsList.prototype.iRemove = function(i) {
    console.log("iRemove  i = " + i);
    this.list = this.list.slice(0, i).concat(this.list.slice(i + 1));
    return this.flatlist = this.flatlist.slice(0, i).concat(this.flatlist.slice(i + 1));
  };

  return PointsList;

})();

ConnectionHelper = (function() {
  function ConnectionHelper(boardHelper) {
    this.boardHelper = boardHelper;
    this.chains = {
      green: [],
      red: []
    };
  }

  ConnectionHelper.prototype.addBridge = function(color, a, b) {
    var ch, chx, connect, ends, i, i1, i2, j, ref;
    ends = this.findEndpoints(color, a, b);
    connect = this.findConnectingChains(color, ends);
    switch (connect.length) {
      case 0:
        return this.chains[color].push([ends[0], ends[1]]);
      case 1:
        ch = this.chains[color][connect[0]];
        if (ch.indexOf(ends[0]) < 0) {
          ch.push(ends[0]);
        }
        if (ch.indexOf(ends[1]) < 0) {
          return ch.push(ends[1]);
        }
        break;
      case 2:
        chx = [];
        i1 = connect[0];
        i2 = connect[1];
        for (i = j = 0, ref = this.chains[color].length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
          if (!(i === i1 || i === i2)) {
            chx.push(this.chains[color][i]);
          }
        }
        chx.push(this.chains[color][i1].concat(this.chains[color][i2]));
        return this.chains[color] = chx;
    }
  };

  ConnectionHelper.prototype.findConnectingChains = function(color, ends) {
    var connect, i, j, ref;
    connect = [];
    if (this.chains[color].length > 0) {
      for (i = j = 0, ref = this.chains[color].length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
        if (this.chains[color][i].indexOf(ends[0]) >= 0) {
          connect.push(i);
        }
        if (this.chains[color][i].indexOf(ends[1]) >= 0) {
          connect.push(i);
        }
      }
    }
    return connect;
  };

  ConnectionHelper.prototype.findEndpoints = function(color, a, b) {
    var dir, e1, e2;
    dir = this.boardHelper.findVH(color, a, b);
    if (dir === 'vert') {
      e1 = 100 * a + b - 1;
      e2 = e1 + 2;
    } else {
      e1 = 100 * (a - 1) + b;
      e2 = e1 + 200;
    }
    return [e1, e2];
  };

  ConnectionHelper.prototype.winner = function() {
    if (this.checkGreen()) {
      return 'green';
    } else {
      if (this.checkRed()) {
        return 'red';
      } else {
        return 'none';
      }
    }
  };

  ConnectionHelper.prototype.checkGreen = function() {
    var gr;
    gr = this.chains.green.some(function(ch) {
      return ch.some(function(pt) {
        return pt % 100 === 0;
      }) && ch.some(function(pt) {
        return pt % 100 === 16;
      });
    });
    return gr;
  };

  ConnectionHelper.prototype.checkRed = function() {
    var rd;
    rd = this.chains.red.some(function(ch) {
      return ch.some(function(pt) {
        return pt >= 1 && pt <= 15 && pt % 2 === 1;
      }) && ch.some(function(pt) {
        return pt >= 1601 && pt <= 1615 && pt % 2 === 1;
      });
    });
    return rd;
  };

  return ConnectionHelper;

})();

BridgeDraw = (function() {
  function BridgeDraw(canvasContext, boardHelper) {
    this.context = canvasContext;
    this.helper = boardHelper;
    this.bcolors = {
      'green': '#146614',
      'red': '#993333'
    };
  }

  BridgeDraw.prototype.drawBridge = function(color, a, b) {
    var colorcode, ht1, ht2, vh, wd1, wd2, x1, x2, xx, xxyy, y1, y2, yy;
    console.log("call BridegDraw.drawBridge( " + color + ", " + a + ", " + b + ")");
    colorcode = this.bcolors[color];
    xxyy = this.helper.getXY(a, b);
    xx = xxyy[0];
    yy = xxyy[1];
    vh = this.helper.findVH(color, a, b);
    if (vh === 'vert') {
      x1 = xx - 3;
      x2 = x1 + 1;
      y1 = yy - 18;
      y2 = y1;
      wd1 = 7;
      wd2 = 5;
      ht1 = 37;
      ht2 = 37;
    } else {
      x1 = xx - 18;
      x2 = x1;
      y1 = yy - 3;
      y2 = y1 + 1;
      wd1 = 37;
      wd2 = 37;
      ht1 = 7;
      ht2 = 5;
    }
    this.context.fillStyle = '#000000';
    this.context.fillRect(x1, y1, wd1, ht1);
    this.context.fillStyle = colorcode;
    return this.context.fillRect(x2, y2, wd2, ht2);
  };

  BridgeDraw.prototype.yellowdot = function(a, b) {
    var xy;
    console.log("yellowdot(" + a + ", " + b + ")");
    xy = this.helper.getXY(a, b);
    this.context.fillStyle = "#ffff00";
    this.context.beginPath();
    this.context.arc(xy[0] + 0.5, xy[1] + 0.5, 10, 0, 2 * Math.PI, false);
    this.context.fill();
    this.context.stroke();
    return this.context.closePath();
  };

  return BridgeDraw;

})();

BoardGeometryHelper = (function() {
  function BoardGeometryHelper() {}

  BoardGeometryHelper.prototype.getAB = function(x, y) {
    var a, b;
    a = Math.floor((x - 18) / 25);
    b = Math.floor((y - 18) / 25);
    if ((a + b) % 2 !== 0 || a < 1 || a > 15 || b < 1 || b > 15) {
      return [-1, -1];
    } else {
      return [a, b];
    }
  };

  BoardGeometryHelper.prototype.getXY = function(a, b) {
    var x, y;
    x = 30 + 25 * a;
    y = 30 + 25 * b;
    return [x, y];
  };

  BoardGeometryHelper.prototype.findVH = function(color, a, b) {
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

  return BoardGeometryHelper;

})();
