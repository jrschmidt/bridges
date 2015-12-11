# BRIDGES GAME
# by JR Schmidt 2015


# window.onload = ->
#   base = new Image()
#   base.onload = =>
#     bridges = new BridgesApp(base)
#     console.log('base.png Image.onload() called')
#   base.src = 'base.png'



class BridgesApp

  constructor: (base) ->
    console.log('BridgesApp constructor called')
    @canvas = document.getElementById("bridges-canvas")
    @context = @canvas.getContext("2d")
    @context.drawImage(base,0,0)



class LocationFinder
  # Find the gameboard coordinates (a,b) of a pixel on the canvas (x,y).

  find: (x, y) ->
    a = Math.floor((x - 18) / 25)
    b = Math.floor((y - 18) / 25)
    if (a + b) % 2 != 0 or a < 1 or a > 15 or b < 1 or b > 15
      return [-1, -1]
    else
      return [a, b]
