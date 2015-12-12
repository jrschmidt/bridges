describe "Points status object", ->

  it "should remove an item from an array", ->
    points = new PointsList
    points.list = [1,2,3,4,5,6,7,8,9]
    points.remove(13)
    expect(points.list.length).toEqual(9)
    points.remove(6)
    expect(points.list.length).toEqual(8)
    points.remove(1)
    expect(.length).toEqual(7)
    points.remove(8)
    expect(z.length).toEqual(6)


  it "should generate a fresh list of open points", ->
    points = new PointsList
    list = points.list

    expect(list.length).toEqual(113)
    expect(list).toContain([1,1])
    expect(list).toContain([15,1])
    expect(list).toContain([1,15])
    expect(list).toContain([15,15])
    expect(list).toContain([6,12])
    expect(list).toContain([4,14])
    expect(list).toContain([11,3])
    expect(list).toContain([8,10])
    expect(list).toContain([5,13])
    expect(list).toContain([9,7])
