describe "Board geometry helper", ->

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



  it "should find the base pixel for gamepoint [a,b]", ->
    helper = new BoardGeometryHelper

    base = helper.getXY(11,5)
    expect(base[0]).toEqual(305)
    expect(base[1]).toEqual(155)

    base = helper.getXY(4,12)
    expect(base[0]).toEqual(130)
    expect(base[1]).toEqual(330)

    base = helper.getXY(7,1)
    expect(base[0]).toEqual(205)
    expect(base[1]).toEqual(55)

    base = helper.getXY(12,6)
    expect(base[0]).toEqual(330)
    expect(base[1]).toEqual(180)

    base = helper.getXY(13,9)
    expect(base[0]).toEqual(355)
    expect(base[1]).toEqual(255)

    base = helper.getXY(2,10)
    expect(base[0]).toEqual(80)
    expect(base[1]).toEqual(280)
