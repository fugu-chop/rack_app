module TemplateProcessor
  def response(status, headers, body = '')
    body = yield if block_given?
    [status, headers, [body]]
  end

  def erb(filename, local = {})
    # Binding relates to closures here - we can capture the all the variables into a single object, using the binding method
    # binding returns a new object with each call. 
    # The returned binding object is able to see and access the local variables defined in the erb method
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
