# Collaborative Editor

This is a very minimal example of demonstrating how Phoenix and RethinkDB
can work together to create a collaborative editor. It intentionally glosses
over a lot things (user registration, document creation, etc.) to simplfy
the demonstration.

You can see a video of it in action here: https://www.youtube.com/watch?v=w4u_o9zlqiA

## Installation

### In one terminal window

  * `brew install rethinkdb`
  * `rethinkdb`

### In other terminal window

  * `mix deps.get`
  * `npm install`
  * `mix phoenix.server`

Visit [localhost:4000/documents/init](http://localhost:4000/documents/init) in your browser. This will
initialize two documents in the DB.
Now visit [localhost:4000/documents](http://localhost:4000/documents) and pick a document
(e.g. `http://localhost:4000/documents/show?id=a48ead01-47f8-4e0a-9742-f8a02437b6c3`).

Add a query param to specify your user:

`http://localhost:4000/documents/show?id=a48ead01-47f8-4e0a-9742-f8a02437b6c3&user=Alice`

Now open up more windows while changing the user:

`http://localhost:4000/documents/show?id=a48ead01-47f8-4e0a-9742-f8a02437b6c3&user=Bob`

`http://localhost:4000/documents/show?id=a48ead01-47f8-4e0a-9742-f8a02437b6c3&user=Eric`

Type in one of the windows and notice how the content in all the windows is updated.
