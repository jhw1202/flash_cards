get '/round/:deck_name' do
  @user = User.find_by_token(session[:token])
  @deck = Deck.find_by_name(params[:deck_name])
  session[:current_round_id] = Round.find_by_user_id_and_deck_id(@user.id, @deck.id)
  @cards = Card.where("deck_id = ?", @deck.id)
  if session[:current_round_id] #resuming play
    @cards.each do |card|
      @current_guess = Guess.find_by_round_id_and_card_id(@round.id, card.id)
      unless @current_guess
        session[:current_card_id] = card.id
        erb :round
      end
    end
    redirect '/home'
  else
    @cards.each do |card|
      session[:current_card_id] = card.id
      erb :round
    end
  end
end

post '/answer' do 
  current_guess = Guess.create(session[:current_round_id], session[:currrent_card_id])
  if Card.find(session[:current_card_id]).answer.downcase == params[:guess].downcase
    current_guess.update_attribute(:correct => true)
  else
    current_guess.update_attribute(:correct => false)
  end

  redirect "/round/#{Deck.find(Round.find(session[:current_round_id].deck_id))}"
end
