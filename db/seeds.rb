User.create(:name => "Tyler Kuhn",
						:email => "tyler@gmail.com",
						:password => "tyler")

User.create(:name => "David Wen",
						:email => "david@gmail.com",
						:password => "david")

User.create(:name => "Philip Woo",
						:email => "philip@gmail.com",
						:password => "philip")

User.create(:name => "Gavin St. Ours",
						:email => "gavin@gmail.com",
						:password => "gavin")

# Deck.create(:name => "Jeopardy")
# Deck.create(:name => "Jokes")
# Deck.create(:name => "Math")

# File.open('db/jeopardy.txt').each_line do |line|
# 	row = line.split(/\ *\t\ */)
# 	begin
# 		Card.create(:question => row[4], :answer => row[6], :value => row[8], :deck => Deck.find_or_create_by_name(row[2]))
# 	rescue
# 		puts "Invalid Row"
# 	end
# end