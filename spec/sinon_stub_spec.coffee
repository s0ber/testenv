describe 'Sinon Stub functionality', ->

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

    @initializeStub = sinon.stub(@Bar::, 'initialize')
    @barInstance = new @Bar(options)

  describe 'stub.withArgs(arg1, arg2, ...)', ->
    it 'should stub method differently based on arguments', ->
      @initializeStub.withArgs(1).returns(1)
      @initializeStub.withArgs(42).throws('TypeError')

      expect(@initializeStub(1)).to.be.equal 1

      try
        @initializeStub(42)
      catch e
        expect(e).to.match(/TypeError/)

  describe 'stub.returns(obj)', ->
    it 'should return provided value when called', ->
      value = 'ololo'

      @initializeStub.returns(value)
      expect(@initializeStub()).to.be.equal(value)

  describe 'stub.returnsArg(index)', ->
    it 'should return the argument at the provided index', ->
      arg1 = 'ololo'
      arg2 = 'pish'

      @initializeStub.returnsArg(0)
      expect(@initializeStub(arg1, arg2)).to.be.equal(arg1)

      @initializeStub.returnsArg(1)
      expect(@initializeStub(arg1, arg2)).to.be.equal(arg2)

  describe 'stub.throws()', ->
    it 'should return an exception (Error)', ->
      @initializeStub.throws()

      try
        @initializeStub()
      catch e
        expect(e).to.be.instanceof(Error)

  describe 'stub.throws("TypeError")', ->
    it 'should return an exception of provided type', ->
      @initializeStub.throws(TypeError)

      try
        @initializeStub()
      catch e
        expect(e).to.match(/TypeError/)

  describe 'stub.callsArg(index)', ->
    it 'should call argument at provided index as callback function', ->
      callbackSpy = sinon.spy(-> 'returned value')

      @initializeStub.callsArg(1)
      @initializeStub('', callbackSpy)

      expect(callbackSpy).to.be.calledOnce
      expect(callbackSpy).to.be.calledAfter(@initializeStub)

  describe 'stub.callsArgOn(index, context)', ->
    it 'should call argument at provided index as callback function in provided context', ->
      callbackSpy = sinon.spy(-> @property)

      context = {property: 'value'}

      @initializeStub.callsArgOn(1, context)
      @initializeStub('', callbackSpy)

      expect(callbackSpy).to.be.calledOnce
      expect(callbackSpy).to.be.calledAfter(@initializeStub)
      expect(callbackSpy.returnValues[0]).to.be.equal 'value'

  describe 'stub.callsArgWith(index, arg1, arg2)', ->
    it 'should call argument at provided index as callback function with provided arguments', ->
      callbackSpy = sinon.spy((arg1, arg2) -> "#{arg1} #{arg2}")

      @initializeStub.callsArgWith(0, 'ololo', 'pish pish')
      @initializeStub(callbackSpy)

      expect(callbackSpy).to.be.calledOnce
      expect(callbackSpy).to.be.calledAfter(@initializeStub)
      expect(callbackSpy.returnValues[0]).to.be.equal 'ololo pish pish'

  describe 'stub.callsArgOnWith(index, context, arg1, arg2)', ->
    it 'should call argument at provided index as callback function in provided context with provided arguments', ->
      callbackSpy = sinon.spy((arg1, arg2) -> "#{arg1} #{arg2} #{@property}")

      context = {property: 'pish'}

      @initializeStub.callsArgOnWith(0, context, 'ololo', 'pish')
      @initializeStub(callbackSpy)

      expect(callbackSpy).to.be.calledOnce
      expect(callbackSpy).to.be.calledAfter(@initializeStub)
      expect(callbackSpy.returnValues[0]).to.be.equal 'ololo pish pish'

  describe 'stub.yields(arg1, arg2, ...)', ->
    it 'should call the first stub callback with provided arguments', ->
      callbackSpy = sinon.spy((arg1, arg2) -> "#{arg1} #{arg2}")

      @initializeStub.yields('ololo', 'pish pish')
      @initializeStub(callbackSpy)

      expect(callbackSpy).to.be.calledOnce
      expect(callbackSpy).to.be.calledAfter(@initializeStub)
      expect(callbackSpy.returnValues[0]).to.be.equal 'ololo pish pish'

  describe 'stub.yield(arg1, arg2, ...)', ->
    it 'should call the first provided callback with provided arguments', ->
      methodStub = sinon.stub()
      callbackSpy = sinon.spy((arg1, arg2) -> "#{arg1} #{arg2}")

      methodStub(callbackSpy)
      methodStub.yield('ololo', 'pish pish')

      expect(callbackSpy).to.be.calledOnce
      expect(callbackSpy).to.be.calledAfter(methodStub)
      expect(callbackSpy.returnValues[0]).to.be.equal 'ololo pish pish'

    it 'should throws an error if not callback provided', ->
      methodStub = sinon.stub()

      methodStub()

      try
        methodStub.yield('ololo', 'pish pish')
      catch e
        expect(e).to.match(/Error: stub cannot yield since no callback was passed/)
