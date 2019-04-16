require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def game
	puts "-------------------------------------------------"
	puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
	puts "|Le but du jeu est d'être le dernier survivant !|"
	puts "-------------------------------------------------"

	puts "What's your name ?"
	print ">"
	name_player = gets.chomp
	puts " "

	human = HumanPlayer.new(name_player)

	player1 = Player.new("Josiane")
	player2 = Player.new("José")
	enemies = [player1, player2]

	while human.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
		puts "Voici l'état de chaque joueur :"
		human.show_state
		player1.show_state
		player2.show_state
		puts " "

		puts "  Quelle action veux-tu effectuer ?"
		puts " "
		puts "a - chercher une meilleure arme "
		puts "s - chercher à se soigner "
		puts " "
		puts "Attaquer un joeur en vue :"
		print "0 - " 
		player1.show_state
		print "1 - " 
		player2.show_state
		puts " "
		print ">"
		#l'utilisateur effectue sa saisie
		choice = gets.chomp
		
		if choice == "a"
			human.search_weapon
		elsif choice == "s"
			human.search_health_pack
		elsif choice == "0"			
			human.attacks(player1)
		elsif choice == "1"
			human.attacks(player2)
		end

		puts " "
		puts "Les autres joueur t'attaquent !"
		puts " "

		enemies.each do |player|
			if player.life_points > 0
				player.attacks(human)
			end	
		end

		puts " "

	end

	if human.life_points > 0
		puts "BRAVO ! TU AS GAGNE !"
	else
		puts "Loser ! Tu as perdu !"
	end
end

game
binding.pry