gulp = require 'gulp'
watch = require 'gulp-watch'
webserver = require 'gulp-webserver'

jade = require 'gulp-jade'

sourcemaps = require 'gulp-sourcemaps'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'

less = require 'gulp-less'

del = require 'del'
mainBowerFiles = require 'main-bower-files'
runSequence = require 'run-sequence'

src = 'src'
dist = 'dist'

gulp.task 'webserver', ->
  gulp.src "#{dist}/"
    .pipe webserver(
      port: 3000
      livereload: true
    )

gulp.task 'clean', (cb) ->
  del "#{dist}/", cb

gulp.task 'bower', ->
  gulp.src mainBowerFiles(), {base: 'bower_components'}
  .pipe gulp.dest "#{dist}/libs"

gulp.task 'jade', ->
  gulp.src "#{src}/**/*.jade"
  .pipe jade()
  .pipe gulp.dest "#{dist}/"

gulp.task 'scripts', ->
  gulp.src "#{src}/scripts/**/*.coffee"
  .pipe sourcemaps.init()
  .pipe coffee()
  .pipe concat 'app.min.js'
  .pipe uglify()
  .pipe sourcemaps.write()
  .pipe gulp.dest "#{dist}/scripts/"

gulp.task 'styles', ->
  gulp.src "#{src}/styles/**/*.less"
#  .pipe sourcemaps.init()
  .pipe less({paths: ['bower_components/bootstrap/less']})
  .pipe concat 'style.css'
#  .pipe sourcemaps.write()
  .pipe gulp.dest "#{dist}/styles/"

gulp.task 'watch', ->
  gulp.watch "#{src}/**/*.jade", ['jade']
  gulp.watch "#{src}/scripts/**/*.coffee", ['scripts']
  gulp.watch "#{src}/styles/**/*.less", ['styles']

gulp.task 'build', ['clean'], (cb) ->
  runSequence [
    'bower'
    'jade'
    'scripts'
    'styles'
  ], cb

gulp.task 'default', ['build'], (cb) ->
  runSequence [
    'watch'
    'webserver'
  ], cb
