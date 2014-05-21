module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      js:
        src: 'src/*.coffee'
        dest: 'jquery.foolmaps.js'
        options: bare: true

    uglify:
      js:
        src: '<%= coffee.js.dest %>'
        dest: 'jquery.foolmaps.min.js'

    watch:
      files: ['src/*.coffee']
      tasks: ['default']
  )

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', [
    'coffee:js'
    'uglify:js'
  ]
