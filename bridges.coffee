# BRIDGES GAME
# by JR Schmidt 2015


window.onload = ->
  bridges = new BridgesApp



class BridgesApp

  constructor: ->
    # @drawWheel = new ColorWheelDraw
    # @drawWheel.draw_wheel()



# class ColorWheelDraw
#
#   constructor: ->
#     @canvas = document.getElementById('jcolor-canvas')
#     @context = @canvas.getContext('2d')
#
#
#   draw_wheel: () ->
#     @context.strokeStyle = "#339933"
#     @context.lineWidth = 3
#     @context.fillStyle = "#0000cc"
#     @context.beginPath()
#     @context.arc(300,300,200,0,2*Math.PI,false)
#     @context.fill()
#     @context.stroke()
#     @context.closePath()
