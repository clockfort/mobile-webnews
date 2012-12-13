# Installation #

Mobile-WebNews uses [cabal](http://www.haskell.org/cabal/) to build itself and its dependencies, so setup is fairly straight-forward.
It is *highly recommended* to use `cabal-dev` to form a project-local dependency installation, as many of the dependencies depend on each others' version dependant selves, and avoiding [Haskell's own infamous dependancy hell](http://www.reddit.com/r/haskell/comments/f3ykj/psa_use_cabaldev_to_solve_dependency_problems/).

    cd mobile-webnews/
    cabal-dev install --force-reinstalls

This should take around 3.5 minutes of (single-threaded :-( ) compilation time on a modern i7. You may need to grab from your system package manager `libcurl-devel`, as you will need the headers to build the Haskell wrapper.
