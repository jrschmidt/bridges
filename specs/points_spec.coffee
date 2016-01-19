describe "Points status object", ->

  it "should generate a fresh list of open points", ->
    @points = new PointsList
    list = @points.list

    expect(list.length).toEqual(113)
    expect(list.indexOf(101)).toBeGreaterThan(-1)
    expect(list.indexOf(1501)).toBeGreaterThan(-1)
    expect(list.indexOf(115)).toBeGreaterThan(-1)
    expect(list.indexOf(1515)).toBeGreaterThan(-1)
    expect(list.indexOf(612)).toBeGreaterThan(-1)
    expect(list.indexOf(414)).toBeGreaterThan(-1)
    expect(list.indexOf(1103)).toBeGreaterThan(-1)
    expect(list.indexOf(810)).toBeGreaterThan(-1)
    expect(list.indexOf(513)).toBeGreaterThan(-1)
    expect(list.indexOf(907)).toBeGreaterThan(-1)


  it "should remove an item from an array", ->

    @points = new PointsList
    expect(@points.list.length).toEqual(113)
    @points.remove(18,32)
    expect(@points.list.length).toEqual(113)
    @points.remove(4,10)
    expect(@points.list.length).toEqual(112)
    @points.remove(13,7)
    expect(@points.list.length).toEqual(111)
    @points.remove(12,8)
    expect(@points.list.length).toEqual(110)
    @points.remove(5,3)
    expect(@points.list.length).toEqual(109)


  it "should determine if an item is in the list", ->

    @points = new PointsList
    expect(@points.listContains(6,12)).toBe(true)
    expect(@points.listContains(4,14)).toBe(true)
    expect(@points.listContains(13,7)).toBe(true)
    expect(@points.listContains(5,3)).toBe(true)
    expect(@points.listContains(6,7)).toBe(false)
    expect(@points.listContains(12,1)).toBe(false)
    expect(@points.listContains(4,88)).toBe(false)
    expect(@points.listContains(43,5)).toBe(false)

    @points.remove(5,3)
    expect(@points.listContains(5,3)).toBe(false)
    @points.remove(13,7)
    expect(@points.listContains(13,7)).toBe(false)
    @points.remove(4,14)
    expect(@points.listContains(4,14)).toBe(false)
    @points.remove(6,12)
    expect(@points.listContains(6,12)).toBe(false)
