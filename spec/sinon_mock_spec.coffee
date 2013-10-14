describe 'Sinon Mock functionality', ->

  options = option: 'value', anotherOption: 'value'

  beforeEach ->
    @Foo = class
      constructor: (@options) ->
        @initialize(@options)

      initialize: (@options) ->
        'returned string'

    @Bar = class extends @Foo
      initialize: (@options) ->
        'returned string'

    @barInstance   = new @Bar(options)
    @barMock       = sinon.mock(@barInstance)

  describe 'expectation.atLeast(number)', ->
    it 'should expect method being called at least `number` times', ->
      @barMock.expects('initialize').atLeast(2)

      @barInstance.initialize()
      @barInstance.initialize()

      @barMock.verify()
