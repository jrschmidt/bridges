# BRIDGES GAME
# by JR Schmidt 2016


window.onload = ->
  base = new Image()
  base.onload = =>
    @bridges = new BridgesApp(base)
    console.log('base.png Image.onload() called')
  base.src = 'base.png'


@mousedown = (e) ->
  @canvas = document.getElementById('bridges-canvas')
  dx = @canvas.offsetLeft
  dy = @canvas.offsetTop
  px = e.pageX
  py = e.pageY
  x = px-dx
  y = py-dy
  console.log "[@mousedown] click at #{x}, #{y}"
  @bridges.handleClick(x,y)



class BridgesApp

  constructor: (base) ->
    console.log('BridgesApp constructor called')
    @canvas = document.getElementById("bridges-canvas")
    @context = @canvas.getContext("2d")
    @context.drawImage(base,0,0)
    @temp = 'green'

    @boardHelper = new BoardGeometryHelper
    @points = new PointsList
    @connect = new ConnectionHelper(@boardHelper)
    @bridgeDraw = new BridgeDraw(@context, @boardHelper)


  handleClick: (xx,yy) ->
    console.log "BridgesApp.handleClick(#{xx}, #{yy})"
    ab = @boardHelper.getAB(xx,yy)
    if ab[0] >= 0
      console.log "(#{xx}, #{yy}) --> (#{ab[0]}, #{ab[1]})"
      @bridgeDraw.drawBridge(@temp, ab[0], ab[1])
      if @temp == 'green'
        @temp = 'red'
      else
        @temp = 'green'



class PointsList

# Here we keep a list of empty gameboard points in two parallel arrays, @list[]
# and @flatlist.

# @list is a plain list of the game points, with each point written as an
# array with the coordinates like this: [7,13].

# @flatlist is a list of the same points, but each point is written as a
# single integer, where [a, b] is converted to a*100 + b. So if
# @list[i] = [7, 13], then @flatlist[i] = 713, and if
# @list[i] = [15, 3], then @flatlist[i] = 1503.

# This is done to make it easier to use array functions such as indexOf(),
# which only works for 'scalar' values.

# [ [7,13], [15,3], [6,10] ].indexOf([6,10])
# will return -1 (even though [6,10] is in the array), but

# [713, 1503, 610].indexOf(610)
# will return 2.

  constructor: ->
    @list = []
    @flatlist = []
    for b in [1..15]
      if b % 2 == 1
        for a in [1..15] by 2
          @list.push( [a, b] )
          @flatlist.push(a*100 + b)
      else
        for a in [2..14] by 2
          @list.push( [a, b] )
          @flatlist.push(a*100 + b)


  remove: (point) ->
    i = @flatlist.indexOf(100*point[0] + point[1])
    if i >= 0
      @list = @list[0 .. (i-1)].concat(@list[(i+1) ..])
      @flatlist = @flatlist[0 .. (i-1)].concat(@flatlist[(i+1) ..])



class ConnectionHelper

  constructor: (boardHelper) ->
    @boardHelper = boardHelper


  findEndpoints: (color, a, b) ->
    dir = @boardHelper.findVH(color, a, b)
    if dir == 'vert'
      e1 = 100*a + b - 1
      e2 = e1 + 2
    else
      e1 = 100 * (a-1) + b
      e2 = e1 + 200
    return [e1, e2]



class BridgeDraw

  constructor: (canvasContext, boardHelper) ->
    @context = canvasContext
    @helper = boardHelper
    @bcolors = {
      'green': '#146614'
      'red': '#993333'
    }


  drawBridge: (color, a, b) ->
    console.log("call BridegDraw.drawBridge( #{color}, #{a}, #{b})")
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



# Draw a yellow dot for test purposes.
  yellowdot: (a,b) ->
    console.log("yellowdot(#{a}, #{b})")
    xy = @helper.getXY(a,b)
    @context.fillStyle = "#ffff00"
    @context.beginPath()
    @context.arc(xy[0] + 0.5,xy[1] + 0.5,10,0,2*Math.PI,false)
    @context.fill()
    @context.stroke()
    @context.closePath()



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
