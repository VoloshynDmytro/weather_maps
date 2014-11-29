@locationsApp.factory 'Location', ['railsResourceFactory', (railsResourceFactory) ->
  return railsResourceFactory({url: '/api/locations', name: 'location'});
]