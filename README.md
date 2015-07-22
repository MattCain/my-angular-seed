# my-angular-seed
My personal angular seed using my preferred stack. Some simple routing is included, much like in angular-seed.

Clone the repo then run

    npm install
    bower install

to install all the dependencies.

Use `grunt serve` to run the connect server for development, use `grunt build` to do a full build.

Included Dependencies:

* Angular + ui.router
* Bootstrap + ngBootstrap
* jQuery
* Underscore

Development stack:

* Coffeescript
* Less

When developing using `grunt serve` all coffee, less and html is watch'd and the page is livereloaded when changes are made.

Grunt optimisation modules:

* usemin
* autoprefixer
* concat
* uglify
* cssmin
* filerev
* htmlmin
* svgmin
* imagemin