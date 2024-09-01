# Super Portal

## Overview

You're building your own real estate portal (it's always been your dream) but you unfortunately don't have any properties to put on your fancy new website. You luckily strike a deal with EasyBroker where they offer you an XML feed of all their properties. In production these files contain more than 300,000 properties!

You can see an example XML file with documentation at [doc/sample-easybroker-feed_1_02.xml](doc/sample-easybroker-feed_1_02.xml) and view a file with a few hundred sample properties at [doc/sample-easybroker-data-feed_1_02.xml](doc/sample-easybroker-data-feed_1_02.xml) which you can assume would be regularly updated in production. Your job is to synchronize the the sample data file with your local database.

## Requirements

### Database and Models

For the purpose of this project you must use the provided sqlite database even though it's not made for production. There are a base set of models to get you started and you should respect their validations but you can add fields or new database columns if you deem them necessary.

### Synchronizer

Implement the [EasyBrokerSynchronizer](app/synchronizers/easy_broker_synchronizer.rb) class. You aren't limited to creating just one class but this should be where you initiate the synchronizing code which you can call via the provided task `rails synchronize_properties:all`. The responsibility of the class is to read the feed and synchronize it with your database. We already implemented a method in the class to read the XML using our [easy_sax](https://github.com/easybroker/easy_sax) gem but you can use another approach to read the file if you want.

Keep in mind that only a small number of properties change in the feed. Most, probably more than 90%, will not change. Also you are only loading a subset of the related fields that you plan to use. In a future version you plan to add videos, images and other related objects. Your solution should ideally take into account the cost of loading all of these objects in the future.

Below are the requirements for synchronizing.

* Don't add new property features. Just use the values provided in seed.rb or ignore any others that don't match those in the feed.
* The property's external_id should be set to the id in the feed.
* If a property in the feed changes you should update it in the database.
* If a property no longer appears in the feed, set the published field to false. You shouldn't delete it.
* You can ignore extra fields in the XML that aren't already in the schema.
* You will be working with hundreds of thousands of properties so performance and memory should be taken into account. Your code should use a constant amount of memory and be able to work with 10 or 100 million properties without increasing the memory used.

### Tests

Make sure to provide unit and/or functional tests for you code since we don't send anything to production without decent coverage and it's also a good way to document your code. We also use minitest at EasyBroker but you're free to use another test framework if you prefer. There are already several tests and fixtures provided and all should pass if you run `rails test`.

## Evaluation Criteria

- Clean, clear and scalable code (e.g., short methods, good naming, easy to change and understand)
- Uses good programming and OOP practices
- Good performance and memory usage (e.g., don't store large objects in memory, optimize database calls)
- The code you deliver should be considered high quality and ready to be used in a production environment and reviewed by your peers
- Decent test coverage

## Deliverables

You should deliver the project sharing a link to a fork of the repo (Please do not send a Pull Request o create a new repo). Be sure to replace the notes section below with your own notes.

## Notes

Add any notes here about your design decisions or improvements you would have made if you had more time. You also might want to consider the following questions for inspiration

* Are there any performance issues with your code or things that you could easily speed up?
* Can it successfully load a file with a 100 million properties on a server with less than 1 GB? Briefly explain why it can or can't load it.
* Are there any areas of your code that you think isn't that "clean"?
* If you weren't able to finish what were you able to complete and were you happy with your progress given the time constraints?

## Setup Using Docker

You can install all the project dependencies on your computer or you can use Docker if you want.

* Install Docker
* Build the image: `docker build -t super-portal .`
* Create the container: ``docker create --name super-portal-container -v `pwd`:/super_portal -p 3000:3000 super-portal`` (if you're on Windows replace `` `pwd` `` with `%cd%`)
* Run the container: `docker start super-portal-container`

Launch a Bash terminal within the container with the following command: `docker exec -it super-portal-container bash`.

You can also execute single commands using `docker exec`, e.g.: `docker exec super-portal-container rails test`.
