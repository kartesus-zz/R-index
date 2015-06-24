# R Packages Index

## Server
The server stores data about the packages.

### Updating the index
To update the index feed it with the URL for the `PACKAGES` manifest.

    $ curl \
     -X POST \
     -d "http://cran.r-project.org/src/contrib/PACKAGES" \
     http://localhost:1982/updates

### Listing packages
It's also possible to retrieve a list of indexed packages.

    $ curl http://localhost:1982/packages.json

## CLI client
To make it easier to manage the index we provide a command line interface for the api

    $ bin/rpackages update # updates the index
    $ bin/rpackages list # lists the packages
