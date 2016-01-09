describe "Connection functions", ->

  it "should find connecting neighbors for a gameboard point", ->
    connect = new ConnectionHelper

    points = connect.findConnectors('green', 7, 7)
    expect(points.length).toEqual(6)
    expect(points).toContain([7,5])
    expect(points).toContain([6,6])
    expect(points).toContain([8,6])
    expect(points).toContain([6,8])
    expect(points).toContain([8,8])
    expect(points).toContain([7,9])

    points = connect.findConnectors('red', 7, 7)
    expect(points.length).toEqual(6)
    expect(points).toContain([6,6])
    expect(points).toContain([8,6])
    expect(points).toContain([5,7])
    expect(points).toContain([9,7])
    expect(points).toContain([6,8])
    expect(points).toContain([8,8])

    points = connect.findConnectors('green', 14, 8)
    expect(points.length).toEqual(5)
    expect(points).toContain([13,7])
    expect(points).toContain([15,7])
    expect(points).toContain([12,8])
    expect(points).toContain([13,9])
    expect(points).toContain([15,9])

    points = connect.findConnectors('red', 14, 8)
    expect(points.length).toEqual(6)
    expect(points).toContain([14,6])
    expect(points).toContain([13,7])
    expect(points).toContain([15,7])
    expect(points).toContain([13,9])
    expect(points).toContain([15,9])
    expect(points).toContain([14,10])

    points = connect.findConnectors('green', 11, 15)
    expect(points.length).toEqual(3)
    expect(points).toContain([11,13])
    expect(points).toContain([10,14])
    expect(points).toContain([12,14])

    points = connect.findConnectors('red', 11, 15)
    expect(points.length).toEqual(4)
    expect(points).toContain([10,14])
    expect(points).toContain([12,14])
    expect(points).toContain([9,15])
    expect(points).toContain([13,15])

    points = connect.findConnectors('green', 1, 1)
    expect(points.length).toEqual(2)
    expect(points).toContain([2,2])
    expect(points).toContain([1,3])

    points = connect.findConnectors('red', 1, 1)
    expect(points.length).toEqual(2)
    expect(points).toContain([3,1])
    expect(points).toContain([2,2])

    points = connect.findConnectors('green', 1, 15)
    expect(points.length).toEqual(2)
    expect(points).toContain([1,13])
    expect(points).toContain([2,14])

    points = connect.findConnectors('red', 1, 15)
    expect(points.length).toEqual(2)
    expect(points).toContain([2,14])
    expect(points).toContain([3,15])

    points = connect.findConnectors('green', 10, 4)
    expect(points.length).toEqual(6)
    expect(points).toContain([9,3])
    expect(points).toContain([11,3])
    expect(points).toContain([8,4])
    expect(points).toContain([12,4])
    expect(points).toContain([9,5])
    expect(points).toContain([11,5])

    points = connect.findConnectors('red', 10, 4)
    expect(points.length).toEqual(6)
    expect(points).toContain([10,2])
    expect(points).toContain([9,3])
    expect(points).toContain([11,3])
    expect(points).toContain([9,5])
    expect(points).toContain([11,5])
    expect(points).toContain([10,6])

    points = connect.findConnectors('green', 3, 5)
    expect(points.length).toEqual(6)
    expect(points).toContain([3,3])
    expect(points).toContain([2,4])
    expect(points).toContain([4,4])
    expect(points).toContain([2,6])
    expect(points).toContain([4,6])
    expect(points).toContain([3,7])

    points = connect.findConnectors('red', 3, 5)
    expect(points.length).toEqual(6)
    expect(points).toContain([2,4])
    expect(points).toContain([4,4])
    expect(points).toContain([1,5])
    expect(points).toContain([5,5])
    expect(points).toContain([2,6])
    expect(points).toContain([4,6])



  xit "should add a link to the list of chains"
