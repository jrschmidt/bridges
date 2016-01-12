describe "Connection functions", ->

  beforeAll ->
    boardHelper = new BoardGeometryHelper
    @connect = new ConnectionHelper(boardHelper)


  it "should find end points for a bridge placed on a gameboard point", ->

    points = @connect.findEndpoints('green', 7, 7)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(706)
    expect(points[1]).toEqual(708)

    points = @connect.findEndpoints('red', 7, 7)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(607)
    expect(points[1]).toEqual(807)

    points = @connect.findEndpoints('green', 14, 8)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1308)
    expect(points[1]).toEqual(1508)

    points = @connect.findEndpoints('red', 14, 8)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1407)
    expect(points[1]).toEqual(1409)

    points = @connect.findEndpoints('green', 11, 15)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1114)
    expect(points[1]).toEqual(1116)

    points = @connect.findEndpoints('red', 11, 15)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1015)
    expect(points[1]).toEqual(1215)

    points = @connect.findEndpoints('green', 1, 1)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(100)
    expect(points[1]).toEqual(102)

    points = @connect.findEndpoints('red', 1, 1)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1)
    expect(points[1]).toEqual(201)

    points = @connect.findEndpoints('green', 1, 15)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(114)
    expect(points[1]).toEqual(116)

    points = @connect.findEndpoints('red', 1, 15)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(15)
    expect(points[1]).toEqual(215)

    points = @connect.findEndpoints('green', 10, 4)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(904)
    expect(points[1]).toEqual(1104)

    points = @connect.findEndpoints('red', 10, 4)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1003)
    expect(points[1]).toEqual(1005)

    points = @connect.findEndpoints('green', 3, 5)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(304)
    expect(points[1]).toEqual(306)

    points = @connect.findEndpoints('red', 3, 5)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(205)
    expect(points[1]).toEqual(405)



  it "should create a new chain when a single unlinked bridge is placed", ->

    @connect.addBridge('green', 8, 6)
    expect(@connect.chains.red.length).toEqual(0)
    expect(@connect.chains.green.length).toEqual(1)
    expect(@connect.chains.green[0].length).toEqual(2)
    expect(@connect.chains.green[0]).toContain(706)
    expect(@connect.chains.green[0]).toContain(906)

    @connect.addBridge('red', 11, 11)
    expect(@connect.chains.green.length).toEqual(1)
    expect(@connect.chains.red.length).toEqual(1)
    expect(@connect.chains.red[0].length).toEqual(2)
    expect(@connect.chains.red[0]).toContain(1011)
    expect(@connect.chains.red[0]).toContain(1211)

    @connect.addBridge('green', 3, 13)
    expect(@connect.chains.red.length).toEqual(1)
    expect(@connect.chains.green.length).toEqual(2)
    expect(@connect.chains.green[1].length).toEqual(2)
    expect(@connect.chains.green[1]).toContain(312)
    expect(@connect.chains.green[1]).toContain(314)

    @connect.addBridge('red', 4, 14)
    expect(@connect.chains.green.length).toEqual(2)
    expect(@connect.chains.red.length).toEqual(2)
    expect(@connect.chains.red[1].length).toEqual(2)
    expect(@connect.chains.red[1]).toContain(413)
    expect(@connect.chains.red[1]).toContain(415)

    @connect.addBridge('green', 4, 6)
    expect(@connect.chains.red.length).toEqual(2)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.green[2].length).toEqual(2)
    expect(@connect.chains.green[2]).toContain(306)
    expect(@connect.chains.green[2]).toContain(506)

    @connect.addBridge('red', 9, 13)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.red[2].length).toEqual(2)
    expect(@connect.chains.red[2]).toContain(813)
    expect(@connect.chains.red[2]).toContain(1013)



  xit "should add a new bridge to a chain", ->

    @connect.addBridge('green', 5, 7)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.green[2].length).toEqual(3)
    expect(@connect.chains.green[2]).toContain(306)
    expect(@connect.chains.green[2]).toContain(506)
    expect(@connect.chains.green[2]).toContain(508)

    @connect.addBridge('red', 13, 11)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.red[0].length).toEqual(3)
    expect(@connect.chains.red[0]).toContain(1011)
    expect(@connect.chains.red[0]).toContain(1211)
    expect(@connect.chains.red[0]).toContain(1411)

    @connect.addBridge('green', 10, 6)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.green[0].length).toEqual(3)
    expect(@connect.chains.green[0]).toContain(706)
    expect(@connect.chains.green[0]).toContain(906)
    expect(@connect.chains.green[0]).toContain(1106)

    @connect.addBridge('red', 8, 12)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.red[2].length).toEqual(3)
    expect(@connect.chains.red[2]).toContain(813)
    expect(@connect.chains.red[2]).toContain(1013)
    expect(@connect.chains.red[2]).toContain(811)

    @connect.addBridge('green', 3, 11)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.green[1].length).toEqual(3)
    expect(@connect.chains.green[1]).toContain(312)
    expect(@connect.chains.green[1]).toContain(314)
    expect(@connect.chains.green[1]).toContain(310)

    @connect.addBridge('red', 5, 3)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.red.length).toEqual(4)
    expect(@connect.chains.red[3].length).toEqual(2)
    expect(@connect.chains.red[3]).toContain(403)
    expect(@connect.chains.red[3]).toContain(603)

    @connect.addBridge('green', 8, 8)
    expect(@connect.chains.red.length).toEqual(4)
    expect(@connect.chains.green.length).toEqual(4)
    expect(@connect.chains.green[3].length).toEqual(2)
    expect(@connect.chains.green[3]).toContain(708)
    expect(@connect.chains.green[3]).toContain(908)



  xit "should combine two chains when a new bridge joins them together", ->

    @connect.addBridge('red', 10, 12)
    expect(@connect.chains.green.length).toEqual(4)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.red[0].length).toEqual(2)
    expect(@connect.chains.red[0]).toContain(413)
    expect(@connect.chains.red[0]).toContain(415)
    expect(@connect.chains.red[1].length).toEqual(2)
    expect(@connect.chains.red[1]).toContain(403)
    expect(@connect.chains.red[1]).toContain(603)
    expect(@connect.chains.red[2].length).toEqual(6)
    expect(@connect.chains.red[2]).toContain(1011)
    expect(@connect.chains.red[2]).toContain(1211)
    expect(@connect.chains.red[2]).toContain(1411)
    expect(@connect.chains.red[2]).toContain(813)
    expect(@connect.chains.red[2]).toContain(1013)
    expect(@connect.chains.red[2]).toContain(811)

    @connect.addBridge('green', 7, 7)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.green[0].length).toEqual(3)
    expect(@connect.chains.green[0]).toContain(312)
    expect(@connect.chains.green[0]).toContain(314)
    expect(@connect.chains.green[0]).toContain(310)
    expect(@connect.chains.green[1].length).toEqual(3)
    expect(@connect.chains.green[1]).toContain(306)
    expect(@connect.chains.green[1]).toContain(506)
    expect(@connect.chains.green[1]).toContain(508)
    expect(@connect.chains.green[2].length).toEqual(5)
    expect(@connect.chains.green[2]).toContain(706)
    expect(@connect.chains.green[2]).toContain(906)
    expect(@connect.chains.green[2]).toContain(1106)
    expect(@connect.chains.green[2]).toContain(708)
    expect(@connect.chains.green[2]).toContain(908)

    @connect.addBridge('red', 7, 13)
    expect(@connect.chains.green.length).toEqual(3)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.red[2].length).toEqual(7)
    expect(@connect.chains.red[2]).toContain(1011)
    expect(@connect.chains.red[2]).toContain(1211)
    expect(@connect.chains.red[2]).toContain(1411)
    expect(@connect.chains.red[2]).toContain(813)
    expect(@connect.chains.red[2]).toContain(1013)
    expect(@connect.chains.red[2]).toContain(811)
    expect(@connect.chains.red[2]).toContain(613)

    @connect.addBridge('green', 6, 8)
    expect(@connect.chains.red.length).toEqual(3)
    expect(@connect.chains.green.length).toEqual(2)
    expect(@connect.chains.green[0].length).toEqual(3)
    expect(@connect.chains.green[0]).toContain(312)
    expect(@connect.chains.green[0]).toContain(314)
    expect(@connect.chains.green[0]).toContain(310)
    expect(@connect.chains.green[1].length).toEqual(8)
    expect(@connect.chains.green[1]).toContain(306)
    expect(@connect.chains.green[1]).toContain(506)
    expect(@connect.chains.green[1]).toContain(508)
    expect(@connect.chains.green[1]).toContain(706)
    expect(@connect.chains.green[1]).toContain(906)
    expect(@connect.chains.green[1]).toContain(1106)
    expect(@connect.chains.green[1]).toContain(708)
    expect(@connect.chains.green[1]).toContain(908)
