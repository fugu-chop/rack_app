require_relative 'advice'
require_relative 'template_processor'

# We could also inherit the class from the other file to link the two
class App
  include TemplateProcessor

  def call(env)
    case env['REQUEST_PATH']
    when '/'
      # The response body (i.e. the last element of the array) has to be an object that responds to the `.each` method. 
      # In this case, we opt for an Array, since this represents the simplest implementation that allows us to get the response body to the client.
      # We've used a symbol here, though a string object will also work as the object referenced by filename.
      # We take a string value (the contents of a .erb file) and pass that in ERB.new. 
      status = '200'
      headers = { "Content-Type" => 'text/html' }
      response(status, headers) { erb :index }
    when '/advice'
      piece_of_advice = Advice.new.generate  
      status = '200'
      headers = { "Content-Type" => 'text/html' }
      # If the method is expecting a positional argument at the end, any name: value pairs that aren't treated as keyword arguments get gathered up into a single hash.
      response(status, headers) { erb :advice, message: piece_of_advice }
    else
      status = '404'
      headers = { "Content-Type" => 'text/html', "Content-Length" => '61' }
      response(status, headers) { erb :not_found }
    end
  end
end
