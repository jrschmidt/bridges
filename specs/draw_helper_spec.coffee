describe "Drawing helpers", ->

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
