TreasureMapper
==============

A JSON to object graph mapper in CoffeeScript

## How to use
```coffeescript
class Baz
    constructor: (@foo, @bar) ->

    fooBar: () ->
        "qwop"

foo = new DataMapper
foo.addPrototypeDetector (data, propertyPath) ->
    return Baz.prototype if propertyPath == 'baz'

data = {foo: 'bar', baz: {foo: 1, bar: 'quux'}}

mappedObj = foo.mapData(data)
```
