require_relative 'advice'

class App
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      # The response body (i.e. the last element of the array) has to be an object that responds to the `.each` method. 
      # In this case, we opt for an Array, since this represents the simplest implementation that allows us to get the response body to the client.
      # We've used a symbol here, though a string object will also work as the object referenced by filename.
      # We take a string value (the contents of a .erb file) and pass that in ERB.new. 
      ['200', {"Content-Type" => "text/html"}, [erb(:index)]]
    when '/advice'
      piece_of_advice = Advice.new.generate
      ['200', {"Content-Type" => 'text/html'}, [erb(:advice, message: piece_of_advice)]]
    else
      ['404', {"Content-Type" => 'text/html'}, [erb(:not_found)]]
    end
  end

  private 

  def erb(filename, local = {})
    # Binding relates to closures here - we can actually capture the bindings as a variable
    # Binding returns a new object with each call rather than a reference. 
    # There is some sort of magic going on inside the returned object that lets binding see and access the local variables defined in the method
    # This is why when we pass b to the `result` instance method, it has context of the message local variable
    b = binding

    # This takes the value from our passed in hash and assigns it to a variable. 
    # The key we’re expecting is called :message, and if that key doesn’t exist, then the message variable is nil. 
    message = local[:message]
    content = File.read("views/#{filename}.erb")
    # The message local variable is then made available within our ERB template when we pass in the binding, b, to our ERB template object
    # We use the #result method to get a 100% HTML string output for the response body.
    ERB.new(content).result(b)
  end
end
