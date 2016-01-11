describe "Location finder", ->

  it "should determine gameboard coordinates of a pixel", ->
    helper = new BoardGeometryHelper

    loc = helper.getAB(0,0)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = helper.getAB(420,420)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = helper.getAB(42,42)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = helper.getAB(43,43)
    expect(loc[0]).toEqual(1)
    expect(loc[1]).toEqual(1)

    loc = helper.getAB(246,109)
    expect(loc[0]).toEqual(9)
    expect(loc[1]).toEqual(3)

    loc = helper.getAB(87,185)
    expect(loc[0]).toEqual(2)
    expect(loc[1]).toEqual(6)

    loc = helper.getAB(339,222)
    expect(loc[0]).toEqual(12)
    expect(loc[1]).toEqual(8)

    loc = helper.getAB(130,280)
    expect(loc[0]).toEqual(4)
    expect(loc[1]).toEqual(10)

    loc = helper.getAB(275,320)
    expect(loc[0]).toEqual(10)
    expect(loc[1]).toEqual(12)

    loc = helper.getAB(112,83)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = helper.getAB(334,151)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = helper.getAB(130,205)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = helper.getAB(350,277)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = helper.getAB(220,362)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)
