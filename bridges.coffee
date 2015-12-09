# BRIDGES GAME
# by JR Schmidt 2015


window.onload = ->
  base = new Image()
  base.onload = =>
    bridges = new BridgesApp(base)
    console.log('base.png Image.onload() called')
  base.src = 'base.png'


class BridgesApp

  constructor: (base) ->
    console.log('BridgesApp constructor called')
    @canvas = document.getElementById("bridges-canvas")
    @context = @canvas.getContext("2d")
    @context.drawImage(base,0,0)
