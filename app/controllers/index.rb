get '/' do
  # Log in or sign up; user can't do anything until then.
  erb :index
end

post '/login' do
  # take params to authenticate user
  # give session token
  redirect '/home'
end

post '/signup' do
  # take params and create new user
  # assign session token
  redirect '/home'
end

get '/home' do
  # Choose a deck to start a round
  # See results from past rounds (link to '/history')
  erb :home
end

get '/round' do
  # Set a session[:deck_id] and session[:card_id]
  # Shows the user the next card in the deck
  # Takes a guess in an input field
  # Records the guess as either correct or incorrect; associates guess with card
  erb :round
end

post '/guess' do
  # Make a new guess object, taking in :round_id and :card_id
  # Compare guess to correct answer, store true/false
  # increment :card_id
  redirect 
end


get '/results' do
  # Destroy session[:deck_id] and session[:card_id]
  # Give correct/incorrect score
  # List cards that had incorrect guesses
  erb :results
end

get '/history' do
  # Show user result history
  # (Deck name, correct/incorrect score, date played)
  erb :history
end
