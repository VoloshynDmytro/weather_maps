angular.module('app.measurementsApp').factory 'Measurement', ['$resource',
  class Measurement
    constructor: (locationId) ->
      @measurement = $resource('/api/locations/:location_id/measurements/:id',
        {location_id: locationId, id: '@id'})

    create: (attrs) ->
      new @measurement(measurement: attrs).$save (measurement) ->
        attrs.id = measurement.id
      attrs

    all: ->
      @measurement.query()
]