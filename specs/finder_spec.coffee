describe "Location finder", ->

  it "should determine gameboard coordinates of a pixel", ->
    finder = new LocationFinder

    loc = finder.find(0,0)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = finder.find(420,420)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = finder.find(42,42)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = finder.find(43,43)
    expect(loc[0]).toEqual(1)
    expect(loc[1]).toEqual(1)

    loc = finder.find(246,109)
    expect(loc[0]).toEqual(9)
    expect(loc[1]).toEqual(3)

    loc = finder.find(87,185)
    expect(loc[0]).toEqual(2)
    expect(loc[1]).toEqual(6)

    loc = finder.find(339,222)
    expect(loc[0]).toEqual(12)
    expect(loc[1]).toEqual(8)

    loc = finder.find(130,280)
    expect(loc[0]).toEqual(4)
    expect(loc[1]).toEqual(10)

    loc = finder.find(275,320)
    expect(loc[0]).toEqual(10)
    expect(loc[1]).toEqual(12)

    loc = finder.find(112,83)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = finder.find(334,151)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = finder.find(130,205)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = finder.find(350,277)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)

    loc = finder.find(220,362)
    expect(loc[0]).toEqual(-1)
    expect(loc[1]).toEqual(-1)
