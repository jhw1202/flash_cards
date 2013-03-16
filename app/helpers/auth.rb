def create_token
	[('a'..'z').to_a, ('A'..'Z').to_a, (0..9).to_a].flatten.shuffle.join
end

def get_current_user(token)
	User.find_by_token(token) if token
end

def assign_token(user)
	token = create_token
  session[:token] = token
  user.token = token
  user.save
end
