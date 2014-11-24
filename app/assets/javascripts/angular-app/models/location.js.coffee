@app.factory 'Location', ['$resource',
  class Location
    constructor: ->
      @location = $resource('/api/locations/:id',
        {id: '@id'})

    create: (attrs) ->
      new @location(location: attrs).$save (location) ->
        attrs.id = location.id
      attrs

    all: ->
      @location.query()
]