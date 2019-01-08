# TaskList

A simple task list application powered by Ruby on Rails. This application also uses

* Bootstrap
* jQuery
* Docker
* CoffeeScript
* SCSS
* HTML

## Setup

```sh
# Make sure you have Node, Ruby 2.5.3, and Docker installed
docker pull postgres
npm run serve
# Go to localhost:3000 afterwards to see the site
```

Other available scripts can be found in `package.json`.

## Features List/Requirement Spec

### Key

* :x: = requirement has not implemented
* :warning: = requirement implementation is incomplete and/or buggy, not working as intended
* :white_check_mark: = requirement is implemented and works as intended

### Models

#### TaskList

##### Database Columns

* `id:integer`, primary key :white_check_mark:
* `name:string` :white_check_mark:
* `user_id:integer`, foreign key :white_check_mark:
* `timestamp:datetime (created_at, updated_at)` :white_check_mark:

##### Associations

* `belongs_to` user :warning:
* `has_many` tasks :white_check_mark:
* `has_many` categories through a join table :warning:

##### Validations

* `user` must be reference to user, can't be null :warning:
* `name` must be string, can't be null, 100 char limit :white_check_mark:

##### Features

* uses `acts_as_list` to order and position `tasks` accordingly :warning:
* `created_at` and `updated_at` timestamps created/updated automatically :white_check_mark:

----

#### Task

##### Database Columns

* `id:integer`, primary key :white_check_mark:
* `task_list_id:integer`, foreign key :white_check_mark:
* `status:string`, defaults to `10` :white_check_mark:
* `description:text` :white_check_mark:
* `position:integer` :white_check_mark:
* `timestamp:datetime (created_at, updated_at)` :white_check_mark:

##### Associations

* `belongs_to` task_list :white_check_mark:

##### Validations

* `task_list_id` must be an integer, can't be null :white_check_mark:
* `status` must be an integer, must be in the `statuses` key set :white_check_mark:
* `name` must be a string, can't be null, 100 char limit :white_check_mark:
* `description` must be a string, 25,000 char limit :white_check_mark:
* `position` must be an integer, cannot be null :white_check_mark:

##### Features

* `status` should be an enum called `status` that maps `:created, :completed, :deleted` to `10, 20, 30` respectively :white_check_mark:
* `created_at` and `updated_at` timestamps created/updated automatically :white_check_mark:

----

#### Categories

##### Database Columns

* `id:integer` primary key :white_check_mark:
* `name:string` :white_check_mark:
* `timestamp:datetime` (created_at, updated_at) :white_check_mark:

##### Associations

* `has_many` task_lists through a join table :warning:

##### Validations

* `name` must be a string, can't be null, 100 char limit :white_check_mark:

##### Features

* `created_at` and `updated_at` timestamps created/updated automatically :white_check_mark:

----

#### Categories/TaskList Join Table

##### Database Columns

* `category_id:integer` foreign key :white_check_mark:
* `task_list_id:integer` foreign key :white_check_mark:

##### Validations

* `category` not null, points to a valid category :warning:
* `task_list` not null, points to a valid task list :warning:

----

### Controllers

* The following controllers will exist:
   * `app/controllers/task_lists_controller.rb` :white_check_mark:
   * `app/controllers/tasks_controller.rb` :white_check_mark:
   * `app/controllers/admin/categories_controller.rb` :white_check_mark:
   * `app/controllers/admin/task_lists_controller.rb` :white_check_mark:
   * `app/controllers/admin/tasks_controller.rb` :white_check_mark:
   * `app/controllers/admin/categories_controller.rb` :white_check_mark:

* Admin controllers will be in their own `Admin` namespace and extend base functionality from their respective regular `user` controllers :white_check_mark:
* `TaskList#index` will fetch all of the user's personal task lists :warning: *(currently gets all task lists)*
* `TaskList#show` will fetch all `tasks` associated with the specified `task_list` :white_check_mark:
* `Admin::TaskList#index` will fetch *all* task lists :warning:

----

### Views

#### Routes

* The root url will redirect to `task_lists/index` :white_check_mark:
* All `admin` controllers are namespaced :white_check_mark:

----

#### User Views

**`views/task_list/index.html.erb`**

* Displays a title saying `My Tasks` at the top of the page :white_check_mark:
* List the user's `TaskLists` sorted alphabetically by name :warning:
* For each `TaskList`, display its `name` and the number of `Tasks` associated with it :white_check_mark:
* Uses Bootstrap's `List Group Component` :white_check_mark:
* Displays a link above the list of `TaskLists` to create a new `TaskList` :white_check_mark:
* Clicking the name of a `TaskList` will redirect to `views/task_list/show.html.erb` :white_check_mark: 

#### Admin Views

**`/admin/task_list/`**

### Required Technology

