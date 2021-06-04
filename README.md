# rack
A repo to test out building a simple `rack` app.

### Basic Overview
This is a very basic project to practice setting up a `rack` application. There's no navigation, but a series of URLs that can be accessed, which do different things:
- '/': This simply displays "Hello world". Groundbreaking stuff.
- '/advice': This randomly selects from an array of moving quotes and displays them. Refresh the page to display another quote
- Anything else, will display a `404` error.

There are two `.rb` files - `app.rb` basically sets up all the routing, with the response headers and body, while `template_processor.rb` handles the rendering of content for the view templates.

### How to run
This project is meant to be run locally:
1. Clone the repo locally
2. Make sure you have the `bundle` gem installed.
3. Run `bundle install` in your CLI
4. Run `bundle exec rackup config.ru -p 9595` in your CLI
5. Visit `http://localhost:9595` in your web browser

### Challenges
This was my first experience working with the `rack` package. It's very manual, having to set up all the response headers and body. I can't imagine this scaling very well, so a framework like Sinatra is likely to be very helpful in abstracting all this stuff away.
