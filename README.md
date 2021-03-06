# Welcome to BetterTiss

BetterTiss is a proxy for the website hosted by the technical university of
vienna (TU Wien). With this web application you can query following objects of
the TISS (TISS - Information Systems and Services of the TU Wien):

* People
* Courses
* Projects
* Theses

You can login or create a new account to be able to favorite the different
objects of the four categories. A user of the service doesn't need to be logged
in to use the searches, but cannot favorite objects.

A user, once logged in, can view other users favorites, favorite, and edit
his/her own profile. To edit the user profile image, a gravatar account is
needed (https://de.gravatar.com/).

## Team

This project was made for the LVA 188.519 (UE 2019S) for the TU Wien by
Hurbean Alexander (e1625747) and Bernhard Ploder (e1627766)

## Dependencies

For production following dependencies are needed (from Gemfile):

* ruby 2.6.1
* rails 5.2.2
* sqlite
* puma
* sass-rails
* uglifier
* duktape
* coffee-rails 
* turbolinks
* jbuilder
* bcrypt
* faker
* httparty
* jquery-rails
* will_paginate
* rdoc
* yard
* bootsnap
* tzinfo-data

For development additional dependencies are needed:

* web-console

For test additional dependencies are needed:

* capybara
* selenium-webdriver
* minitest-reporters
* rails-controller-testing
* webdriver
* win32console

For development and test additional dependencies are needed:

* byebug
* spring
* better_errors
* binding_of_caller

## Commands

### Setup

Before starting for the first time make sure you have all the needed gems 
installed by running `bundle install` or just `bundle` once.

Next (if everything succeeded) migrate the database with the command
  
  ```rake db:migrate```

To fill the database with dummy data run `rake db:seed` (optional)

### Testing

To test the application run `rake test` or just `rake t`

### Running

To run the server on localhost run

  ```rails s```

there are additional arguments such as 

* `--binding` with preferably `0.0.0.0` to open the server to the
outside
* `--port` with preferably `80` to respond to all incoming
http requests

so to run the server to the outside world run following command

``` rails s --binding 0.0.0.0 --port 80 ```

## Structure 

```
  ├───app
  │   ├───assets
  │   ├───controllers
  │   │   └───concerns
  │   ├───helpers
  │   ├───models
  │   │   └───concerns
  │   └───views
  │       ├───courses
  │       ├───layouts
  │       ├───people
  │       ├───projects
  │       ├───sessions
  │       ├───shared
  │       ├───theses
  │       └───users
  ├───db
  │   ├───migrate
  │   └───seeds.rb
  └───test
```

The project has a standard rails folder structure with each folder containing
the usual files such as views, models and controllers. As we make use of
concerns for abstractions, the folders also contain files.

## Architecture

### Users

The users and their sessions have their own views, controllers, and models. We
use bcrypt for authentication and password digest storing. Vari ous user helper
function have been written to the users_helper.rb file to ease the interaction
with the user.

For creating, destroying and storing of user sessions we have a controller that
manages the users session and is user for logging in, logging out and
remembering.

The user model has relationships to the other four models to be able to favorite
each of them.

### People, Projects, Courses, Theses

These can be queried (via search or detail) from TISS and their TISS ID with
which one is identified will be stored in our database if an user has favorited
one of these elements once.

All of the data is being loaded from TISS via REST requests every time a user
requests an object (via search or detail view).

The way the system works is, that the search is generically being provided by
each model with the Searchable module. Once a user enters a search, a request is
begin sent to the correct TISS REST Url which returns a JSON or XML. The system
parses the reponse and maps all of the attributes to the objects which then can
be displayed.

Once a user favorites one object, its tiss_id is remembered in the database and
saved in a relationship with the user.

### Concerns

#### Favoritable

Including the Favoritable module in a ApplicationController makes the controller
support the favoritable path for its objects. All that is needed is the route
that needs to be configured (see routes.rb for examples).

#### MassAssignable

This ActiveSupport::Concern Module adds functions to easily create new
attr_accessor dynamically for a object (or in our case models). This plays well
with the hash that is supplied by loading information via rest, which can be
assigned to the object so that access with the "." operator is possible.

#### RESTObject

Is a Mass Assignable, as stated before, works well together for mass assigning
all values received. RESTObject overwrites the assign_hash by setting the
tiss_id inside the hash so that that value is always available for all objects
automatically.

A model that is a RESTObject always ensures it has all of the needed information
loaded from the TISS Server, and if not, loads it (via tiss_id) and massively
assigns it to the model object.


#### Searchable

A model that is Searchable needs to supply a tiss_search_link, and a way to
extract the tiss_id from any possible given hash. With that information a new
ClassMethod is begin added to the models class which allows a user to search
TISS for objects of the given Class.