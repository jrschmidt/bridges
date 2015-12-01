# describe "Color stats helper", ->
#
#   beforeEach ->
#     @statHelper = new ColorStatsHelper
#
#
#   it "should sort colors by value", ->
#     @sorter = new ColorSorter
#
#     order = @sorter.sort(0xff, 0xaa, 0x33)
#     expect(order[0]).toEqual('red')
#     expect(order[1]).toEqual('green')
#     expect(order[2]).toEqual('blue')
#
#     order = @sorter.sort(0x00, 0x99, 0xcc)
#     expect(order[0]).toEqual('blue')
#     expect(order[1]).toEqual('green')
#     expect(order[2]).toEqual('red')
#
#     order = @sorter.sort(0x31, 0x33, 0x32)
#     expect(order[0]).toEqual('green')
#     expect(order[1]).toEqual('blue')
#     expect(order[2]).toEqual('red')
#
#     order = @sorter.sort(0xcc, 0xff, 0x66)
#     expect(order[0]).toEqual('green')
#     expect(order[1]).toEqual('red')
#     expect(order[2]).toEqual('blue')
