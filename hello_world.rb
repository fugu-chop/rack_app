require_relative 'advice'

class HelloWorld
  # Rack configuration files use `run` to say what application we want to run on our server. 
  # We created a HelloWorld class which will act as our web application and is where most of our application code will be.
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      # We take a string value (the contents of index.erb) and pass that in ERB.new. 
      # We can then use the #result method to get a 100% HTML string output for the response body. 
      # The difference this time is that we’re getting that string value from a file, the view template.
      # Technically speaking, we don't need this right now, as there's no dynamic content in the index.erb file
      template = File.read("views/index.erb")
      content = ERB.new(template)
      # The response body (i.e. the last element of the array) has to be an object that responds to the `.each` method. 
      # In this case, we opt for an Array, since this represents the simplest implementation that allows us to get the response body to the client.
      ['200', {"Content-Type" => "text/html"}, [content.result]]
    when '/advice'
      piece_of_advice = Advice.new.generate
      [
        '200',
        {"Content-Type" => 'text/html'},
        ["<html><body><b><em>#{piece_of_advice}</em></b></body></html>"]
      ]
    else
      [
        '404',
        {"Content-Type" => 'text/html', "Content-Length" => '48'},
        ["<html><body><h4>404 Not Found</h4></body></html>"]
      ]
    end
  end
end
