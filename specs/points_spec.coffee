describe "Points status object", ->

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
