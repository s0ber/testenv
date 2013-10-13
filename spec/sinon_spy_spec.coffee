describe 'Sinon Spy functionality', ->

  options = option: 'value', anotherOption: 'value'

  beforeEach ->
    @Foo = class
      constructor: (@options) ->
        @initialize(@options)

      initialize: (@options) ->

    @Bar = class extends @Foo
      initialize: (@options) ->

    @initializeSpy = sinon.spy(@Bar::, 'initialize')
    @barInstance = new @Bar(options)

  describe '.calledOnce', ->
    it 'checks if method was called once', ->
      expect(@initializeSpy).to.be.calledOnce

  describe '.calledWith', ->
    it 'checks if method was called with specified argument', ->
      expect(@initializeSpy).to.be.calledWith(options)

  describe 'Spy object methods', ->

    describe 'spy.withArgs', ->
      # this is an alias to `.calledWith`
      it 'checks if method was called with exact specified arguments', ->
        expect(@initializeSpy.withArgs(options)).to.be.calledOnce
        expect(@initializeSpy.withArgs(options)).to.be.calledOnce

    describe 'spy.callCount', ->
      it 'checks if method was called exact amount times', ->
        expect(@initializeSpy.callCount).to.be.equal(1)

    describe 'spy.called', ->
      it 'checks if method was called at least once', ->
        expect(@initializeSpy.called).to.be.true
        expect(@initializeSpy).to.be.called

    describe 'spy.calledOnce', ->
      # this is an alias to `.calledOnce`
      it 'checks if method was called exactly once', ->
        expect(@initializeSpy.calledOnce).to.be.true
        expect(@initializeSpy).to.be.calledOnce

    describe 'spy.calledTwice', ->
      it 'checks if method was called exactly twice', ->
        @barInstance.initialize()
        expect(@initializeSpy.calledTwice).to.be.true
        expect(@initializeSpy).to.be.calledTwice

    describe 'spy.calledThrice', ->
      it 'checks if method was called exactly thrice', ->
        @barInstance.initialize()
        @barInstance.initialize()
        expect(@initializeSpy.calledThrice).to.be.true
        expect(@initializeSpy).to.be.calledThrice

    describe 'spy.calledOn', ->
      it 'checks if method was called on provided object as `this`', ->
        expect(@initializeSpy.calledOn(@barInstance)).to.be.true
        expect(@initializeSpy).to.be.calledOn(@barInstance)

    describe 'spy.alwaysCalledOn', ->
      it 'checks if method was not always called on provided object as `this`', ->
        obj = {}
        @barInstance.initialize.apply(obj, [])

        expect(@initializeSpy).to.be.calledTwice
        expect(@initializeSpy.alwaysCalledOn(@barInstance)).to.be.false

    describe 'spy.calledWithMatch', ->
      it 'checks if method was called with matching arguments', ->
        expect(@initializeSpy.calledWithMatch(option: 'value')).to.be.true
        expect(@initializeSpy.calledWithMatch(anotherOption: 'value')).to.be.true
        expect(@initializeSpy.calledWithMatch({option: 'value', anotherOption: 'value'})).to.be.true

        expect(@initializeSpy).to.be.calledWithMatch(option: 'value')
        expect(@initializeSpy).to.be.calledWithMatch(anotherOption: 'value')
        expect(@initializeSpy).to.be.calledWithMatch({option: 'value', anotherOption: 'value'})

    describe 'spy.neverCalledWith', ->
      it 'checks if method was never called with provided arguments', ->
        expect(@initializeSpy.neverCalledWith('asd')).to.be.true

    describe 'spy.getCall(n)', ->
      it 'checks if spy.getCall returns function call object', ->
        @barInstance.initialize('value')

        initializeSpyCall = @initializeSpy.getCall(0)
        callOptions       = initializeSpyCall.args[0]

        expect(callOptions).to.be.equal(options)

        initializeSpySecondCall = @initializeSpy.getCall(1)
        secondCallOptions       = initializeSpySecondCall.args[0]

        expect(@initializeSpy).to.be.calledTwice
        expect(secondCallOptions).to.be.equal('value')

    describe 'spy.thisValues', ->
      it 'checks if spy.thisValues[0] returns link to `this` object', ->
        expect(@initializeSpy.thisValues[0]).to.be.equal(@barInstance)

    describe 'spy.args', ->
      it 'checks if spy.args[0] returns link to provided arguments', ->
        expect(@initializeSpy.args[0][0]).to.be.equal(options)

    describe 'spy.returnValues', ->
      it 'checks if spy.returnValues[0] returns links returned values', ->
        expect(@initializeSpy.returnValues[0]).to.be.undefined

    describe 'spy.reset', ->
      it 'checks if spy state was reseted', ->
        @initializeSpy.reset()
        expect(@initializeSpy.called).to.be.false


  describe 'Spy call object', ->
    beforeEach ->
      @initializeSpyCall = @initializeSpy.getCall(0)

      @secondObject = {}
      @barInstance.initialize.apply(@secondObject, ['string_argument', 'another_argument'])
      @secondInitializeSpyCall = @initializeSpy.getCall(1)

    describe 'spyCall.calledOn(obj)', ->
      it 'checks if method was called on provided object', ->
        expect(@initializeSpyCall.calledOn(@barInstance)).to.be.true
        expect(@secondInitializeSpyCall.calledOn(@secondObject)).to.be.true

    describe 'spyCall.calledWith(arg)', ->
      it 'checks if method was called with provided arguments', ->
        expect(@initializeSpyCall).to.be.calledWith(options)
        expect(@initializeSpyCall.calledWith(options)).to.be.true

        expect(@secondInitializeSpyCall).to.be.calledWith('string_argument')
        expect(@secondInitializeSpyCall.calledWith('string_argument')).to.be.true

    describe 'spyCall.calledWithExactly(arg)', ->
      it 'checks if method was called on with exactly provided arguments', ->
        expect(@initializeSpyCall).to.be.calledWithExactly(options)
        expect(@initializeSpyCall.calledWithExactly(options)).to.be.true

        expect(@secondInitializeSpyCall).to.be.calledWithExactly('string_argument', 'another_argument')
        expect(@secondInitializeSpyCall.calledWithExactly('string_argument', 'another_argument')).to.be.true

        expect(@secondInitializeSpyCall).to.be.not.calledWithExactly('string_argument')
        expect(@secondInitializeSpyCall.calledWithExactly('another_argument')).to.be.false

    describe 'spyCall.notCalledWith(arg)', ->
      it 'checks if method was not called with provided arguments', ->
        expect(@initializeSpyCall.notCalledWith('string_argument')).to.be.true
