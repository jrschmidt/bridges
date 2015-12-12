# BRIDGES GAME
# by JR Schmidt 2015


window.onload = ->
  base = new Image()
  base.onload = =>
    bridges = new BridgesApp(base)
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
  alert "click at #{x}, #{y}"



class BridgesApp

  constructor: (base) ->
    console.log('BridgesApp constructor called')
    @canvas = document.getElementById("bridges-canvas")
    @context = @canvas.getContext("2d")
    @context.drawImage(base,0,0)

    @points = new PointsList



class PointsList

  constructor: ->
    @list = []
    for b in [1..15]
      if b % 2 == 1
        for a in [1..15] by 2
          @list.push( [a,b] )
      else
        for a in [2..14] by 2
          @list.push( [a,b] )




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
