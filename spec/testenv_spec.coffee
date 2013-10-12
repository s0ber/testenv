describe 'TestEnv', ->

  value = 'My awesome value'

  it 'returns provided value when setting by key', ->
    expect(TestEnv.set('testKey', value)).be.eq value

  it 'returns previously set value when getting by key', ->
    expect(TestEnv.get('testKey')).be.eq value
