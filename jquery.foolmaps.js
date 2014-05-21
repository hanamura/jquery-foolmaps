(function($) {
  return $.fn.foolmaps = function(options) {
    this.each(function() {
      var $e, gm, height, map, opt, url, width;
      $e = $(this);
      opt = $.extend({
        type: $e.attr('data-type') || 'static',
        query: $e.attr('data-query') || '',
        zoom: parseInt($e.attr('data-zoom') || 15),
        lang: $e.attr('data-lang') || 'en',
        prelat: parseInt($e.attr('data-prelat') || 40),
        prelng: parseInt($e.attr('data-prelng') || 133),
        width: parseInt($e.attr('width') || $e.attr('data-width') || 0),
        height: parseInt($e.attr('height') || $e.attr('data-height') || 0),
        sensor: false,
        options: null
      }, options);
      if (opt.type === 'dynamic') {
        gm = google.maps;
        map = new gm.Map(this, $.extend({
          center: new gm.LatLng(opt.prelat, opt.prelng),
          zoom: opt.zoom,
          disableDefaultUI: true,
          streetViewControl: true,
          zoomControl: true
        }, opt.options));
        return new gm.Geocoder().geocode({
          address: opt.query
        }, function(r, s) {
          if (s !== gm.GeocoderStatus.OK) {
            return;
          }
          map.setCenter(r[0].geometry.location);
          return new gm.Marker({
            map: map,
            position: r[0].geometry.location
          });
        });
      } else {
        width = opt.width || Math.ceil($e.innerWidth());
        height = opt.height || Math.ceil($e.innerHeight());
        url = '//maps.googleapis.com/maps/api/staticmap?' + $.param({
          markers: opt.query,
          zoom: opt.zoom,
          size: "" + width + "x" + height,
          scale: window.devicePixelRatio && window.devicePixelRatio > 1 ? 2 : 1,
          lang: opt.lang,
          sensor: false
        });
        if ($e.is('img')) {
          return $e.attr('src', url);
        } else {
          return $e.css({
            backgroundImage: "url(\"" + url + "\")"
          });
        }
      }
    });
    return this;
  };
})(jQuery);
