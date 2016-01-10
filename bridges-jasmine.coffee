# BRIDGES GAME
# by JR Schmidt 2015


# window.onload = ->
#   base = new Image()
#   base.onload = =>
#     @bridges = new BridgesApp(base)
#     console.log('base.png Image.onload() called')
#   base.src = 'base.png'
#
#
# @mousedown = (e) ->
#   @canvas = document.getElementById('bridges-canvas')
#   dx = @canvas.offsetLeft
#   dy = @canvas.offsetTop
#   px = e.pageX
#   py = e.pageY
#   x = px-dx
#   y = py-dy
#   console.log "[@mousedown] click at #{x}, #{y}"
#   @bridges.handleClick(x,y)



class BridgesApp

  constructor: (base) ->
    console.log('BridgesApp constructor called')
    @canvas = document.getElementById("bridges-canvas")
    @context = @canvas.getContext("2d")
    @context.drawImage(base,0,0)

    @points = new PointsList


  handleClick: (xx,yy) ->
    console.log "BridgesApp.handleClick(#{xx}, #{yy})"



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

  constructor: ->
    @vt = [
      [0,-2]
      [-1,-1]
      [1,-1]
      [-1,1]
      [1,1]
      [0,2]
    ]

    @hz = [
      [-1,-1]
      [1,-1]
      [-2,0]
      [2,0]
      [-1,1]
      [1,1]
    ]


  findConnectors: (color, a, b) ->
    cnxx = []
    dir = @findVH(color, a, b)
    if dir == 'vert'
      deltas = @vt
    else
      deltas = @hz
    for d in deltas
      aa = a + d[0]
      bb = b + d[1]
      cnxx.push([aa,bb]) if aa >= 1 && aa <= 15 && bb >= 1 && bb <= 15
    return cnxx


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



class LocationFinder

  # Find the gameboard coordinates (a,b) of a pixel on the canvas (x,y).
  find: (x, y) ->
    a = Math.floor((x - 18) / 25)
    b = Math.floor((y - 18) / 25)
    if (a + b) % 2 != 0 or a < 1 or a > 15 or b < 1 or b > 15
      return [-1, -1]
    else
      return [a, b]
