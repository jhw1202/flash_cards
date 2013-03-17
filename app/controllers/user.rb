get '/stats' do
  @rounds = Round.where("user_id = ?", @current_user.id)
  erb :stats
end
