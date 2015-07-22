module.exports = (grunt) ->

   # load all grunt tasks
   require("load-grunt-tasks")(grunt)

   grunt.initConfig(

      app: "app"
      dist: "dist"

      watch:
         less:
            files: ["<%= app %>/styles/{,*/}*.less"]
            tasks: ["less"]
         coffee:
            files: ["<%= app %>/coffee/{,*/}*.coffee"]
            tasks: ["coffee:server", "coffeelint:server"]
         styles:
            files: ["<%= app %>/styles/{,*/}*.css"]
            tasks: ["copy:styles", "autoprefixer"]
         livereload:
            options:
               livereload: "<%= connect.options.livereload %>"
            files: [
               "<%= app %>/*.html",
               "<%= app %>/templates/{,*/}*.html",
               ".tmp/styles/{,*/}*.css",
               "{.tmp,<%= app %>}/scripts/{,*/}*.js",
               "<%= app %>/images/{,*/}*.{gif,jpeg,jpg,png,svg,webp}"
            ]

      connect:
         options:
            port: 9005
            livereload: 35728
            # change this to "0.0.0.0" to access the server from outside
            hostname: "localhost"
         livereload:
            options:
               open: true
               base: [
                  ".tmp",
                  "<%= app %>"
               ]

      clean:
         dist:
            files: [
               dot: true
               src: [
                  ".tmp",
                  "<%= dist %>/*",
                  "!<%= dist %>/.git*"
               ]
            ]
         server: ".tmp"

      # Put files not handled in other tasks here
      copy:
         dist:
            files: [
               expand: true
               dot: true
               cwd: "<%= app %>"
               dest: "<%= dist %>"
               src: [
                  "*.{ico,png,txt}"
                  ".htaccess"
                  "images/{,*/}*.{webp,gif}"
                  "styles/fonts/{,*/}*.*"
               ]
            ]

      less:
         all:
            files: [
               expand: true
               cwd: "<%= app %>/styles"
               src: ["*.less"]
               dest: ".tmp/styles/"
               ext: ".css"
            ]

      autoprefixer:
         options:
            browsers: ["last 8 versions"]
         dist:
            files: [
               expand: true
               cwd: ".tmp/styles/"
               src: "{,*/}*.css"
               dest: ".tmp/styles/"
            ]

      useminPrepare:
         options:
            dest: "<%= dist %>"
         html: "<%= app %>/index.html"

      usemin:
         options:
            assetsDirs: ["<%= dist %>", "<%= dist %>/images"]
            patterns:
               js: [
                  [/(images\/.*?\.(?:gif|jpeg|jpg|png|webp|svg))/gm, "Update the JS to reference our revved images"]
               ]
         html: ["<%= dist %>/{,*/}*.html"]
         css: ["<%= dist %>/styles/{,*/}*.css"]
         js: ["<%= dist %>/scripts/{,*/}*.js"]

      imagemin:
         dist:
            files: [
               expand: true
               cwd: "<%= app %>/images"
               src: "{,*/}*.{gif,jpeg,jpg,png}"
               dest: "<%= dist %>/images"
            ]

      svgmin:
         dist:
            files: [
               expand: true
               cwd: "<%= app %>/images"
               src: "{,*/}*.svg"
               dest: "<%= dist %>/images"
            ]

      htmlmin:
         dist:
            files: [
               expand: true
               cwd: "<%= app %>"
               src: "*.html"
               dest: "<%= dist %>"
            ]

      filerev:
         options:
            algorithm: "md5",
            length: 5
         files:
            src: [
               "<%= dist %>/scripts/{,*/}*.js",
               "<%= dist %>/styles/{,*/}*.css",
               "<%= dist %>/images/{,*/}*.{gif,jpeg,jpg,png,webp}",
               "<%= dist %>/styles/fonts/{,*/}*.*"
            ]

      coffee:
         server:
            expand: true
            flatten: false
            cwd: "<%= app %>/coffee"
            src: ["{,*/}*.coffee"]
            dest: ".tmp/scripts"
            ext: ".js"
         dist:
            expand: true
            flatten: false
            cwd: "<%= app %>/coffee"
            src: ["{,*/}*.coffee"]
            dest: ".tmp/scripts"
            ext: ".js"

      coffeelint:
         options:
            indentation:
               value: 3
            max_line_length:
               value: 120
         server:
            options:
               force: true
            files:
               src: ["<%= app %>/coffee/{,*/}*.coffee", "Gruntfile.coffee"]

         dist: ["coffee/{,*/}*.coffee", "Gruntfile.coffee"]

      concurrent:
         server: [
            "less",
            "coffeelint:server",
            "coffee:server"
         ]
         dist: [
            "less",
            "coffeelint:dist",
            "coffee:dist",
            "imagemin",
            "svgmin",
            "htmlmin"
         ]
   )

   grunt.registerTask("serve", (target) ->
      grunt.task.run([
         "clean:server",
         "concurrent:server",
         "autoprefixer",
         "connect:livereload",
         "watch"
      ])
   )

   grunt.registerTask("build", [
      "clean:dist",
      "useminPrepare",
      "concurrent:dist",
      "autoprefixer",
      "concat:generated",
      "cssmin:generated",
      "uglify:generated",
      "copy:dist",
      "filerev",
      "usemin"
   ])

   grunt.registerTask("default", [
      "build"
   ])
