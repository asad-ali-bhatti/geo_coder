## Geocoder 
A simple ruby web server application built using Rack and Net/Http libraries. 
Its primary function is to fetch coordinates of a location from google api.
   
### 1. File Architecture
```
├── application.rb
├── config
│   ├── initialize.rb
│   └── routes.rb
├── config.ru
├── Gemfile
├── Gemfile.lock
├── lib
│   ├── controllers
│   │   ├── application_controller.rb
│   │   └── geocoder_controller.rb
│   ├── geocoder.rb
│   └── route.rb
└── spec
    ├── application_spec_helper.rb
    ├── geocoder_spec.rb
    ├── helper_classes.rb
    ├── route_spec.rb
    └── spec_helper.rb
```

### 2. Setup
After cloning github repo cd into it and run following command to setup the application.

* `gem install bundle`
* `bundle install`
* `rackup` to start the server

Note: You need to generate a google API key and store it in `GOOGLE_API_KEY` environment variable.

### 3. Usage 

There is `POST` endpoint `/geocode/code?location=Germany ` available to get coordinates in json format.

#### 3.1. Application Usage
##### 3.1.1. Controllers 
New controllers can be added to application by creating a controller class with resource name 
and inherit it from Application controller.

Each action of the controller receives and object of request. and it has to call response method at the end of the method

Example: 
```
class UserController < ApplicationController
  def show(request)
    response code: 200, body: 'I am user'
  end 
end 
```

##### 3.1.2. Routes
Routes can be registered easily in separate `config/routes.rb` file.

```
 Route.draw do |route|
   route.add controller: 'UserController', action: 'show', method: 'GET'
 end
 ```
 
##### 3.1.3. Application settings
Application level configurations are available in Application Module. you can easily configure them.

```
Application.config do |config|
  config.set :port, 9000
  config.set :google_api_key, ENV['GOOGLE_API_KEY'] #store keys in ENV
end
```
### 4. Answers to Task Questions 

##### How do you handle configuration values?  
Configurations are handled at the time of initialization of application. And stored in Application Module.
configurations can be accessible any where in application using `Application.settings` it will provide hash of settings.

##### What if configuration values change?
Change in configurations values changes it won't affect current instance of application. New configurations take affect
on new instance of application.

##### What happens if we encounter an error with the third-party API integration Will it also break our application, or are they handled accordingly?
Error in 3rd-party api integration wont effect our application as I tried to separate Google service from our action logic.
In case of failure response from google api our application will also send failure response to client. 
