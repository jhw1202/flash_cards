require 'levenshtein'

before do
  @current_user = get_current_user(session[:token])
  @notifications = []
end

get '/deck/:deck_id' do
  @deck = Deck.find(params[:deck_id])
  @rounds = Round.where('user_id = ? AND deck_id = ?', @current_user.id, @deck.id)
  @cards = @deck.cards
  @new_game = true
  if @rounds.last && @rounds.last.guesses.count < @cards.count
    @new_game = false
    # @guesses = @round.guesses
    # @guessed_cards_id = guesses.map { |guess| guess.id }
    # @guessed_cards = Card.where('card_id = ?', @guessed_cards_id)
    # @cards -= @guessed_cards
  end
  erb :deck
end

get '/deck/:deck_id/play' do
  @deck = Deck.find(params[:deck_id]) 
  @round = Round.where('user_id = ? AND deck_id = ?', @current_user.id, @deck.id).last
  @cards = @deck.cards
  if @round && @round.guesses.count < @cards.count
    @guessed_card_ids = @round.guesses.map { |guess| guess.card.id }
    @cards = @cards.reject do |card|  
      @guessed_card_ids.include? card.id
    end
  # elsif @round && @round.guesses.count == @cards.count && session.has_key(:finished) == false
  #   session[:finished] = "0"  
  #   redirect "/deck/#{params[:deck_id]}/play"  
  elsif @round && @round.guesses.count == @deck.cards.count
    puts "HELLO!"
    redirect "/deck/#{params[:deck_id]}/finished_deck"
  else
    # session[:finished] = nil
    @round = Round.create(user_id: @current_user.id, deck_id: @deck.id) #changed from Round.new to Round.create
  end
  @card = session["#{@deck.name}_card"] ||= @cards.sample
  @progress = (@round.guesses.count / @deck.cards.count.to_f * 100).to_i
  # puts @round.guesses.count
  # puts @deck.cards.count

  # erb :finished_deck if @round.guesses.count == @deck.cards.count - 1
  @notifications = ["That was correct!"] if params[:correct]
  erb :play
end

post '/card/:id/answer' do
  @card = Card.find(params[:id])
  @deck = @card.deck
  @round = Round.find_by_user_id_and_deck_id(@current_user, @deck)
  @guess = Guess.new(round: @round, card: @card, correct: false)
  if Levenshtein.normalized_distance(@card.answer, params[:answer]) < 0.42 || params[:answer].to_i == 42
    @guess.correct = true
  end
  @guess.save
  
  session["#{@deck.name}_card"] = nil

  if @guess.correct
    redirect "/deck/#{@deck.id}/play?correct=true"
  else
    erb :card
  end
end

get '/deck/:deck_id/finished_deck' do
  @deck = Deck.find(params[:deck_id])
  @round = Round.where('user_id = ? AND deck_id = ?', @current_user.id, @deck.id).last
  erb :finished_deck 
end
