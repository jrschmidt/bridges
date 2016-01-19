# BRIDGES GAME
# by JR Schmidt 2016


window.onload = ->
  base = new Image()
  base.onload = =>
    @bridges = new BridgesApp(base)
  base.src = 'base.png'


@mousedown = (e) ->
  @canvas = document.getElementById('bridges-canvas')
  dx = @canvas.offsetLeft
  dy = @canvas.offsetTop
  px = e.pageX
  py = e.pageY
  x = px-dx
  y = py-dy
  @bridges.handleClick(x,y)



class BridgesApp

  constructor: (base) ->
    @canvas = document.getElementById("bridges-canvas")
    @context = @canvas.getContext("2d")
    @context.drawImage(base,0,0)

    @boardHelper = new BoardGeometryHelper
    @connectHelper = new ConnectionHelper(@boardHelper)
    @points = new PointsList
    @bridgeDraw = new BridgeDraw(@context, @boardHelper)
    @redAI = new AiPlayer('red', @points)
    @gameStatus = 'yourMove'


  handleClick: (xx,yy) ->
    if @gameStatus == 'yourMove'
      ab = @boardHelper.getAB(xx,yy)
      if ab[0] >= 0
        if @legalMove('green', ab[0], ab[1])
          @bridgeDraw.drawBridge('green', ab[0], ab[1])
          @makeMove('green', ab[0], ab[1])
          if @connectHelper.winner() == 'green'
            @gameStatus = 'youWin'
          else
            @gameStatus = 'waitingForAi'
            redMove = @redAI.chooseMove()
            @bridgeDraw.drawBridge('red', redMove[0], redMove[1])
            @makeMove('red', redMove[0], redMove[1])
            if @connectHelper.winner() == 'red'
              @gameStatus = 'youLose'
            else
              @gameStatus = 'yourMove'


  makeMove: (color, a, b) ->
    @points.remove(a, b)
    @connectHelper.addBridge(color, a, b)
    win = @connectHelper.winner()
    if win == 'green'
      alert('YOU WIN !!!')
    if win == 'red'
      alert('You lose (computer wins).')


  legalMove: (color, a, b) ->
    if @points.listContains(a, b)
      return true
    else
      return false



class AiPlayer

  constructor: (color, points) ->
    @color = color
    @points = points


  chooseMove: ->
    return @points.randomPoint()



class PointsList

# The list of the empty game points is written with the a,b coordinates of each
# point converted to a single integer, where [a, b] is converted to a*100 + b.
# So [7, 13] becomes 713, and [15, 3] becomes 1503.

# This is done to make it easier to use array functions such as indexOf(),
# which only work for 'scalar' values.

# [ [7,13], [15,3], [6,10] ].indexOf([6,10])
# will return -1 (even though [6,10] is in the array), but

# [713, 1503, 610].indexOf(610)
# will return 2.

  constructor: ->
    @list = []
    for b in [1..15]
      if b % 2 == 1
        for a in [1..15] by 2
          @list.push(a*100 + b)
      else
        for a in [2..14] by 2
          @list.push(a*100 + b)


  listContains: (a, b) ->

    if @list.indexOf(a*100 + b) < 0
      return false
    else
      return true


  randomPoint: ->
    i = Math.floor(Math.random() * (@list.length - 1))
    ab = @list[i]
    @iRemove(i)
    b = ab % 100
    a = (ab - b) / 100
    return [a, b]


  remove: (a, b) ->
    i = @list.indexOf(100*a + b)
    @iRemove(i) if i >= 0


  iRemove: (i) ->
    @list = @list.slice(0, i).concat(@list.slice(i + 1))



class ConnectionHelper

  constructor: (boardHelper) ->
    @boardHelper = boardHelper

    @chains = {
      green: []
      red: []
    }


  addBridge: (color, a, b) ->
    ends = @findEndpoints(color, a, b)
    cxChains = @findConnectingChains(color, ends)
    switch cxChains.length
      when 0 #new chain
        @chains[color].push([ends[0], ends[1]])
      when 1 #add to existing chain
        ch = @chains[color][cxChains[0]]
        ch.push(ends[0]) if ch.indexOf(ends[0]) < 0
        ch.push(ends[1]) if ch.indexOf(ends[1]) < 0
      when 2 #new bridge links two chains together
        chx = []
        i1 = cxChains[0]
        i2 = cxChains[1]
        for i in [0 .. @chains[color].length - 1]
          chx.push(@chains[color][i]) if not (i == i1 or i == i2)
        chx.push(@chains[color][i1].concat(@chains[color][i2]))
        @chains[color] = chx



  findConnectingChains: (color, ends) ->
    conxChains = []
    if @chains[color].length > 0
      for i in [0 .. @chains[color].length - 1]
        conxChains.push(i) if @chains[color][i].indexOf(ends[0]) >= 0
        conxChains.push(i) if @chains[color][i].indexOf(ends[1]) >= 0
    return conxChains


  findEndpoints: (color, a, b) ->
    dir = @boardHelper.findVH(color, a, b)
    if dir == 'vert'
      e1 = 100*a + b - 1
      e2 = e1 + 2
    else
      e1 = 100 * (a-1) + b
      e2 = e1 + 200
    return [e1, e2]


  winner: ->
    if @checkGreen()
      return 'green'
    else
      if @checkRed()
        return 'red'
      else
        return 'none'


  checkGreen: ->
    gr = @chains.green.some( (ch) ->
      ch.some( (pt) -> pt % 100 == 0) && ch.some( (pt) -> pt % 100 == 16)
    )
    return gr


  checkRed: ->
    rd = @chains.red.some( (ch) ->
      ch.some( (pt) -> pt >= 1 && pt <= 15 && pt % 2 == 1) && ch.some( (pt) -> pt >= 1601 && pt <= 1615 && pt % 2 == 1)
    )
    return rd



class BridgeDraw

  constructor: (canvasContext, boardHelper) ->
    @context = canvasContext
    @helper = boardHelper
    @bcolors = {
      'green': '#146614'
      'red': '#993333'
    }


  drawBridge: (color, a, b) ->
    colorcode = @bcolors[color]
    xxyy = @helper.getXY(a, b)
    xx = xxyy[0]
    yy = xxyy[1]
    vh = @helper.findVH(color, a, b)
    if vh == 'vert'
      x1 = xx - 3
      x2 = x1 + 1
      y1 = yy - 18
      y2 = y1
      wd1 = 7
      wd2 = 5
      ht1 = 37
      ht2 = 37
    else
      x1 = xx - 18
      x2 = x1
      y1 = yy - 3
      y2 = y1 + 1
      wd1 = 37
      wd2 = 37
      ht1 = 7
      ht2 = 5
    @context.fillStyle = '#000000'
    @context.fillRect(x1,y1,wd1,ht1)
    @context.fillStyle = colorcode
    @context.fillRect(x2,y2,wd2,ht2)



class BoardGeometryHelper

  # Find the gameboard coordinates (a,b) of a pixel on the canvas (x,y).
  getAB: (x, y) ->
    a = Math.floor((x - 18) / 25)
    b = Math.floor((y - 18) / 25)
    if (a + b) % 2 != 0 or a < 1 or a > 15 or b < 1 or b > 15
      return [-1, -1]
    else
      return [a, b]


  # Find the center pixel (x,y) for gameboard coordinates (a,b).
  getXY: (a,b) ->
    x = 30 + 25*a
    y = 30 + 25*b
    return [x,y]


# Determine if the bridge for a particluar color at (a,b) is vertical or horizontal.
  findVH: (color, a, b) ->
    if color == 'green'
      if a % 2 == 1
        return 'vert'
      else
        return 'horz'

    else
      if a % 2 == 1
        return 'horz'
      else
        return 'vert'
