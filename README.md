# README


## A quick rails app to show a restful json api

* ruby 2.2
* rails 4.2.0
* deployed to heroku

##Overview
* This is a basic rails project using rspec as the test framework
* TDD was used
* API is namespaced under "API"


Usage:
You can use the chrome app Postman to test the api with this collection
https://www.getpostman.com/collections/6fc5360c05b10a02dd55

Here are the curl commands for the REST API actions supported


## Create a user

```
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache"  -d '{
  "first_name": "Jimmy",
  "last_name": "Jones",
  "birth_date": "1970-03-06"
}' "https://ff-json-api.herokuapp.com//api/persons"
```



## List Users

N.B. Sort by appending the sort param. Can be one of [first_name, last_name, age]

```
curl -X GET -H "Cache-Control: no-cache"  "https://ff-json-api.herokuapp.com//api/persons?sort=last_name"
```



## Show user
```
curl -X GET -H "Cache-Control: no-cache" -H "Postman-Token: 4709aed0-7cef-2a65-4960-7eeeb5aa312e" "https://ff-json-api.herokuapp.com/api/persons/1"
```



## Update a user
```
curl -X PUT -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '{
  "first_name": "Ed"
}' "https://ff-json-api.herokuapp.com/api/persons/1"
```


## Delete a user
```
curl -X DELETE -H "Content-Type: application/json" -H "Cache-Control: no-cache" "https://ff-json-api.herokuapp.com/api/persons/5"
```


