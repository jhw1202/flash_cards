before do
  @current_user = get_current_user(session[:token])
end

get '/' do
  # Log in or sign up; user can't do anything until then.
  erb :index
end

post '/login' do
  # take params to authenticate user
  # give session token
  user = User.authenticate(params[:email], params[:password])
  if user
    assign_token(user)
    redirect '/home'
  else
    @errors = ['Invalid email/password']
    erb :index
  end
end

post '/signup' do
  # take params and create new user
  # assign session token
  user = User.new(params[:user])
  if user.save
    assign_token(user)
    redirect '/home'
  else
    puts @errors = user.errors.full_messages
    erb :index
  end
end

get '/logout' do
  @current_user.token = nil
  @current_user.save
  session.delete(:token)
  redirect '/'
end

get '/home' do
  redirect '/' unless @current_user
  # Choose a deck to start a round
  # See results from past rounds (link to '/history')
  @user = User.find_by_token(session[:token])
  erb :home
end

get '/round' do
  redirect '/' unless @current_user
  # Set a session[:deck_id] and session[:card_id]
  # Shows the user the next card in the deck
  # Takes a guess in an input field
  # Records the guess as either correct or incorrect; associates guess with card
  erb :round
end

post '/guess' do
  redirect '/' unless @current_user
  # Make a new guess object, taking in :round_id and :card_id
  # Compare guess to correct answer, store true/false
  # increment :card_id
  redirect 
end

get '/results' do
  redirect '/' unless @current_user
  # Destroy session[:deck_id] and session[:card_id]
  # Give correct/incorrect score
  # List cards that had incorrect guesses
  erb :results
end

get '/history' do
  redirect '/' unless @current_user
  # Show user result history
  # (Deck name, correct/incorrect score, date played)
  erb :history
end
