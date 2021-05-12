require_relative 'app'

# Rack configuration files use `run` to say what application we want to run on our server. 
# We created a HelloWorld class which will act as our web application and is where most of our application code will be.
run App.new
