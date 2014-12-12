[Menu Combinator](http://menu-combinator.herokuapp.com)
===============

### Menu -what???

This is a Sinatra app that accepts a data file depicting menu items and prices. The top line in the file represents the total price target. The Combinator works recursively to return a collection of all possible combinations of menu items adding up to exactly the price target.

#### Assumptions

- Results include combinations with more than one of any given item.
- The data upload must be a .txt or .csv file in [this format](https://tablexi-prod.s3.amazonaws.com/comfy/cms/files/files/000/000/007/original/menu.txt). 

#### Features

- Combinator#solve is the recursive method that does most of the heavy lifting. It is an entirely original solution to this type of problem. I've included a time benchmark on the app page for this function and I'm curious how it compares to alternative solutions given heavy loads.
- I've included error handling to ensure that the app doesn't break if given the wrong file type. Front-end scripts take care of file type and presence upon submission, while back-end validations provide a second catch.
- FileParser is Ruby module that handles the parsing. It creates MenuItem objects only if the data format is valid, and collects line numbers that contain issues. In the event of any invalid data, the app will display line numbers to the user.

### Local Set-up

#### Tinker

- Clone this repository.
- Run `bundle` in the terminal to get the gems.
- Run `shotgun` to start a server.
- Visit `localhost:9393` in the browser to use the app.

#### Test

- Run the Rspec tests in the terminal with `bundle exec rspec spec -fd`.


