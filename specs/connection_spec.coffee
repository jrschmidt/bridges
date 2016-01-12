describe "Connection functions", ->

  it "should find end points for a gameboard point", ->
    boardHelper = new BoardGeometryHelper
    connect = new ConnectionHelper(boardHelper)

    points = connect.findEndpoints('green', 7, 7)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(706)
    expect(points[1]).toEqual(708)

    points = connect.findEndpoints('red', 7, 7)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(607)
    expect(points[1]).toEqual(807)

    points = connect.findEndpoints('green', 14, 8)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1308)
    expect(points[1]).toEqual(1508)

    points = connect.findEndpoints('red', 14, 8)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1407)
    expect(points[1]).toEqual(1409)

    points = connect.findEndpoints('green', 11, 15)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1114)
    expect(points[1]).toEqual(1116)

    points = connect.findEndpoints('red', 11, 15)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1015)
    expect(points[1]).toEqual(1215)

    points = connect.findEndpoints('green', 1, 1)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(100)
    expect(points[1]).toEqual(102)

    points = connect.findEndpoints('red', 1, 1)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1)
    expect(points[1]).toEqual(201)

    points = connect.findEndpoints('green', 1, 15)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(114)
    expect(points[1]).toEqual(116)

    points = connect.findEndpoints('red', 1, 15)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(15)
    expect(points[1]).toEqual(215)

    points = connect.findEndpoints('green', 10, 4)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(904)
    expect(points[1]).toEqual(1104)

    points = connect.findEndpoints('red', 10, 4)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(1003)
    expect(points[1]).toEqual(1005)

    points = connect.findEndpoints('green', 3, 5)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(304)
    expect(points[1]).toEqual(306)

    points = connect.findEndpoints('red', 3, 5)
    expect(points.length).toEqual(2)
    expect(points[0]).toEqual(205)
    expect(points[1]).toEqual(405)



  xit "should add a link to the list of chains"
