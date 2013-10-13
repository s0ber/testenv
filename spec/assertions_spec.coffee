describe 'ChaiJS Assertions', ->

  describe '.not', ->
    # Negates any of assertions following in the chain.

    # expect(foo).to.not.equal('bar')
    # expect(goodFn).to.not.throw(Error)
    expect(foo: 'baz').to.have.property('foo')
      .and.not.equal('bar')

  describe '.deep', ->
    # Sets the `deep` flag, later used by the `equal` and `property` assertions.

    # expect(foo).to.deep.equal({ bar: 'baz' })
    expect(foo: {bar: {baz: 'quux'}})
      .to.have.deep.property('foo.bar.baz', 'quux')

  describe '.a(type)', ->
    # The `a` and `an` assertions are aliases
    # that can be used either as language chains or to assert a value's type.

    # typeof
    expect('test').to.be.a('string')
    expect(foo: 'bar').to.be.an('object')
    expect(null).to.be.a('null')
    expect(undefined).to.be.an('undefined')

    # language chain
    # expect(foo).to.be.an.instanceof(Foo)

  describe '.include(value)', ->
    # The `include` and `contain` assertions can be used
    # as either property based language chains
    # or as methods to assert the inclusion of an object
    # in an array or a substring in a string.
    # When used as language chains,
    # they toggle the `contain` flag for the `keys` assertion.
    expect([1, 2, 3]).to.include(2)
    expect('foobar').to.contain('foo')
    expect(foo: 'bar', hello: 'universe').to.include.keys('foo')

  describe '.ok', ->
    # Asserts that the target is truthy.
    expect('everthing').to.be.ok
    expect(1).to.be.ok
    expect(false).to.not.be.ok
    expect(undefined).to.not.be.ok
    expect(null).to.not.be.ok

  describe '.true', ->
    # Asserts that the target is `true`.
    expect(true).to.be.true
    expect(1).to.not.be.true

  describe '.false', ->
    # Asserts that the target is `false`.
    expect(false).to.be.false
    expect(0).to.not.be.false

  describe '.null', ->
    # Asserts that the target is `null`.
    expect(null).to.be.null
    expect(undefined).not.to.be.null

  describe '.undefined', ->
    # Asserts that the target is `undefined`.
    expect(undefined).to.be.undefined
    expect(null).to.not.be.undefined

  describe '.exist', ->
    # Asserts that the target is neither `null` nor `undefined`.
    foo = 'hi'
    bar = null
    baz = undefined

    expect(foo).to.exist
    expect(bar).to.not.exist
    expect(baz).to.not.exist

  describe '.empty', ->
    # Asserts that the target's length is `0`.
    # For arrays, it checks the `length` property.
    # For objects, it gets the count of enumerable keys.
    expect([]).to.be.empty
    expect('').to.be.empty
    expect({}).to.be.empty

  describe '.arguments', ->
    # Asserts that the target is an arguments object.
    expect(arguments).to.be.arguments

  describe '.equal(value)', ->
    # Asserts that the target is strictly equal (===) to `value`.
    # Alternately, if the `deep` flag is set,
    # asserts that the target is deeply equal to `value`.
    expect('hello').to.equal('hello')
    expect(42).to.equal(42)
    expect(1).to.not.equal(true)
    expect(foo: 'bar').to.not.equal(foo: 'bar')
    expect(foo: 'bar').to.deep.equal(foo: 'bar')

  describe '.eql(value)', ->
    # Asserts that the target is deeply equal to `value`.
    expect(foo: 'bar').to.eql(foo: 'bar')
    expect([1, 2, 3]).to.eql([1, 2, 3])

  describe '.above(value)', ->
    # Asserts that the target is greater than `value`.
    expect(10).to.be.above(5)

    # Can also be used in conjunction with `length` to assert a maximum length.
    # The benefit being a more informative error message
    # than if the length was supplied directly.
    expect('foo').to.have.length.above(2)
    expect([ 1, 2, 3 ]).to.have.length.above(2)

  describe '.least(value)', ->
    # Asserts that the target is greater than or equal to `value`.
    expect(10).to.be.at.least(10)

    # Can also be used in conjunction with `length` to assert a maximum length.
    # The benefit being a more informative error message
    # than if the length was supplied directly.
    expect('foo').to.have.length.of.at.least(2)
    expect([ 1, 2, 3 ]).to.have.length.of.at.least(3)

  describe '.below(value)', ->
    # Asserts that the target is less than `value`.
    expect(5).to.be.below(10)

    # Can also be used in conjunction with `length` to assert a maximum length.
    # The benefit being a more informative error message
    # than if the length was supplied directly.
    expect('foo').to.have.length.below(4)
    expect([ 1, 2, 3 ]).to.have.length.below(4)

  describe '.most(value)', ->
    # Asserts that the target is less than or equal to `value`.
    expect(5).to.be.at.most(5)

    # Can also be used in conjunction with `length` to assert a maximum length.
    # The benefit being a more informative error message
    # than if the length was supplied directly.
    expect('foo').to.have.length.of.at.most(4)
    expect([ 1, 2, 3 ]).to.have.length.of.at.most(3)

  describe '.within(start, finish)', ->
    # Asserts that the target is within a range
    expect(7).to.be.within(7,10)

    # Can also be used in conjunction with `length` to assert a length range.
    # The benefit being a more informative error message
    # than if the length was supplied directly.
    expect('foo').to.have.length.within(2,4)
    expect([ 1, 2, 3 ]).to.have.length.within(2,4)

  describe '.instanceof(constructor)', ->
    # Asserts that the target is an instance of `constructor`.
    Tea  = (name) -> this.name = name
    chai = new Tea('chai')

    expect(chai).to.be.an.instanceof(Tea)
    expect([ 1, 2, 3 ]).to.be.instanceof(Array)

  describe '.property(name, [value])', ->
    # Asserts that the target has a property `name`,
    # optionally asserting that the value of that property is strictly equal to `value`.
    # If the `deep` flag is set, you can use dot- and bracket-notation
    # for deep references into objects and arrays.

    # simple referencing
    obj = foo: 'bar'
    expect(obj).to.have.property('foo')
    expect(obj).to.have.property('foo', 'bar')

    # deep referencing
    deepObj =
      green: {tea: 'matcha'}
      teas:  ['chai', 'matcha', {tea: 'konacha'}]

    expect(deepObj).to.have.deep.property('green.tea', 'matcha')
    expect(deepObj).to.have.deep.property('teas[1]', 'matcha')
    expect(deepObj).to.have.deep.property('teas[2].tea', 'konacha')

    # You can also use an array as the starting point
    # of a `deep.property` assertion, or traverse nested arrays.
    arr = [
      ['chai', 'matcha', 'konacha'],
      [
        {tea: 'chai' },
        {tea: 'matcha'},
        {tea: 'konacha'}
      ]
    ]

    expect(arr).to.have.deep.property('[0][1]', 'matcha')
    expect(arr).to.have.deep.property('[1][2].tea', 'konacha')

    # Furthermore, `property` changes the subject of the assertion
    # to be the value of that property from the original object.
    # This permits for further chainable assertions on that property.
    expect(obj).to.have.property('foo')
      .that.is.a('string')

    expect(deepObj).to.have.property('green')
      .that.is.an('object')
      .that.deep.equals(tea: 'matcha')

    expect(deepObj).to.have.property('teas')
      .that.is.an('array')
      .with.deep.property('[2]')
        .that.deep.equals(tea: 'konacha')

  describe '.ownProperty(name)', ->
    # Asserts that the target has an own property `name`.
    expect('test').to.have.ownProperty('length')

  describe '.length(value)', ->
    # Asserts that the target's `length` property has the expected value.
    expect([ 1, 2, 3]).to.have.length(3)
    expect('foobar').to.have.length(6)

    # Can also be used as a chain precursor
    # to a value comparison for the length property.
    expect('foo').to.have.length.above(2)
    expect([ 1, 2, 3 ]).to.have.length.above(2)
    expect('foo').to.have.length.below(4)
    expect([ 1, 2, 3 ]).to.have.length.below(4)
    expect('foo').to.have.length.within(2,4)
    expect([ 1, 2, 3 ]).to.have.length.within(2,4)

  describe '.match(regexp)', ->
    # Asserts that the target matches a regular expression.
    expect('foobar').to.match(/^foo/)

  describe '.string(string)', ->
    # Asserts that the string target contains another string.
    expect('foobar').to.have.string('bar')

  describe '.keys(key1, [key2], [...])', ->
    # Asserts that the target has exactly the given keys,
    # or asserts the inclusion of some keys
    # when using the `include` or `contain` modifiers.
    expect(foo: 1, bar: 2).to.have.keys(['foo', 'bar'])
    expect(foo: 1, bar: 2, baz: 3).to.contain.keys('foo', 'bar')

  describe '.throw(constructor)', ->
    # Asserts that the function target will throw a specific error,
    # or specific type of error (as determined using instanceof),
    # optionally with a RegExp or string inclusion test for the error's message.

    err = new ReferenceError('This is a bad function.')
    fn  = -> throw err

    expect(fn).to.throw(ReferenceError)
    expect(fn).to.throw(Error)
    expect(fn).to.throw(/bad function/)
    expect(fn).to.not.throw('good function')
    expect(fn).to.throw(ReferenceError, /bad function/)
    expect(fn).to.throw(err);
    expect(fn).to.not.throw(new RangeError('Out of range.'))

  describe '.respondTo(method)', ->
    # Asserts that the object or class target will respond to a method.
    Object = (@name) ->
    Object.prototype.bar = ->
    instance = new Object('My name')

    expect(Object).to.respondTo('bar')
    expect(instance).to.respondTo('bar')

    # To check if a constructor will respond to a static function,
    # set the `itself` flag.
    Object.baz = ->
    expect(Object).itself.to.respondTo('baz')

  describe '.itself', ->
    # Sets the `itself` flag, later used by the `respondTo` assertion.
    Foo = ->
    Foo.bar = ->
    Foo.prototype.baz = ->

    expect(Foo).itself.to.respondTo('bar')
    expect(Foo).itself.not.to.respondTo('baz')

  describe '.satisfy(method)', ->
    # Asserts that the target passes a given truth test.
    expect(1).to.satisfy((num) -> num > 0)

  describe '.closeTo(expected, delta)', ->
    # Asserts that the target is equal `expected`, to within a +/- `delta` range.
    expect(1.5).to.be.closeTo(1, 0.5)

  describe '.members(set)', ->
    # Asserts that the target is a superset of `set`,
    # or that the target and `set` have the same members.
    expect([1, 2, 3]).to.include.members([3, 2])
    expect([1, 2, 3]).to.not.include.members([3, 2, 8])

    expect([4, 2]).to.have.members([2, 4])
    expect([5, 2]).to.not.have.members([5, 2, 1])
