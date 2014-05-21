(($) ->
  $.fn.foolmaps = (options) ->
    @each ->
      # jquery
      $e = $ @

      # opt
      opt = $.extend
        type    : $e.attr('data-type') or 'static'
        query   : $e.attr('data-query') or ''
        zoom    : parseInt $e.attr('data-zoom') or 15
        lang    : $e.attr('data-lang') or 'en'
        prelat  : parseInt $e.attr('data-prelat') or 40
        prelng  : parseInt $e.attr('data-prelng') or 133
        width   : parseInt $e.attr('width')  or $e.attr('data-width')  or 0
        height  : parseInt $e.attr('height') or $e.attr('data-height') or 0
        sensor  : false
        options : null
      , options

      # dynamic or static
      if opt.type is 'dynamic'
        gm = google.maps
        # create map
        map = new gm.Map @, $.extend
          center            : new gm.LatLng opt.prelat, opt.prelng
          zoom              : opt.zoom
          disableDefaultUI  : true
          streetViewControl : true
          zoomControl       : true
        , opt.options
        # search query
        new gm.Geocoder().geocode address: opt.query, (r, s) ->
          return if s isnt gm.GeocoderStatus.OK
          map.setCenter r[0].geometry.location
          new gm.Marker
            map      : map
            position : r[0].geometry.location
      else
        # width, height, url
        width  = opt.width  or Math.ceil $e.innerWidth()
        height = opt.height or Math.ceil $e.innerHeight()
        url = '//maps.googleapis.com/maps/api/staticmap?' + $.param
          markers : opt.query
          zoom    : opt.zoom
          size    : "#{width}x#{height}"
          scale   : if window.devicePixelRatio and window.devicePixelRatio > 1 then 2 else 1
          lang    : opt.lang
          sensor  : false
        # apply
        if $e.is 'img'
          $e.attr 'src', url
        else
          $e.css backgroundImage: """url("#{url}")"""
    @
) jQuery
