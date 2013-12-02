class TreasureMapper
    constructor: (@prototypeDetectors = []) ->

    addPrototypeDetector: (prototypeDetector) ->
        @prototypeDetectors.push prototypeDetector

    mapData: (data) ->
        @realMapData data, ''

    realMapData: (data, propertyPath) ->
        return data unless @isObject(data)
        proto = @getPrototype data, propertyPath

        mappedPropertyDescriptors = {}
        for key, value of data
            mappedPropertyDescriptors[key] = { value: @realMapData(value, @createPropertyPath(propertyPath, key)) }

        Object.create proto, mappedPropertyDescriptors

    getPrototype: (data, propertyPath) ->
        proto = null
        for prototypeDetector in @prototypeDetectors
            proto = prototypeDetector(data, propertyPath)
            return proto if proto?

        return Object.prototype

    isObject: (data) ->
        return false if not data?
        Object.prototype.toString.call(data) == '[object Object]'

    createPropertyPath: (base, element) ->
        elements = base.split('.').filter (x) -> x != ''
        elements.push(element)
        elements.join('.')
