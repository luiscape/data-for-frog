## Mapping the CHD Indicators
This experiment aims to try to map the CHD indicators based on their code only. It uses the specifications created by the [new CHD coding scheme](https://github.com/luiscape/data-for-frog/blob/gh-pages/chd_coding_scheme.pdf) to create relationships (links) based on each indicator's many levels.

Take a look at the experiment here: http://luiscape.github.io/data-for-frog/

##Fork of Mike Bostock's original [force-directed example](https://gist.github.com/mbostock/4062045).
This fork uses an ugly csv which unfortunately is just a fact of life in my world.  JSON is highly recommended unless it is unavailable.

##Original readme.md is below and does a very nice job of explaining the graph.

This simple force-directed graph shows character co-occurence in *Les Misérables*. A physical simulation of charged particles and springs places related characters in closer proximity, while unrelated characters are farther apart. Layout algorithm inspired by [Tim Dwyer](http://www.csse.monash.edu.au/~tdwyer/) and [Thomas Jakobsen](http://web.archive.org/web/20080410171619/http://www.teknikus.dk/tj/gdc2001.htm). Data based on character coappearence in Victor Hugo's *Les Misérables*, compiled by [Donald Knuth](http://www-cs-faculty.stanford.edu/~uno/sgb.html).
