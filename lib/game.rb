require 'pry'
require_relative 'player'

class Game
	attr_accessor :human_player, :enemies
 	
 	################INITIALISATION###########################
	def initialize(name)
		@enemies = []
		player1 = Player.new("Ennemis1")
		@enemies.push(player1)
		player2 = Player.new("Ennemis2")
		@enemies.push(player2)
		player3 = Player.new("Ennemis3")
		@enemies.push(player3)

		@human_player = HumanPlayer.new(name)
	end

	#######################KILL#############################
	def kill_player(player)
		@enemies.delete(player)
	end

	#################STILL_ON_GOING#########################
	def is_still_ongoing?
		return @human_player.life_points > 0 && !@enemies.empty?
	end

	#####################SHOW_PLAYERS#######################
	def show_players
		puts "Voici l'état du joueur humain :"
		@human_player.show_state
		puts "Voici le nombre de joueurs bots restant :"
		puts @enemies.size
		puts " "
	end

	##########################MENU#######################
	def menu
		puts "Voici l'état de chaque joueur :"
		@human_player.show_state
		@enemies.each do |player|
			player.show_state
		end
		puts " "

		puts "  Quelle action veux-tu effectuer ?"
		puts " "
		puts "a - chercher une meilleure arme "
		puts "s - chercher à se soigner "
		puts " "
		puts "Attaquer un joeur en vue :"

		#pour chaque ennemis 
		i = 0 #c'est notre compteur
		@enemies.each do |player|
			print "#{i}- " 
			player.show_state
			i +=1
		end
		puts " "
	end

	#####################MENU_CHOICE#####################
	def menu_choice
		print ">"
		#l'utilisateur effectue sa saisie
		choice = gets.chomp
		
		if choice == "a"
			@human_player.search_weapon
		elsif choice == "s"
			@human_player.search_health_pack
		elsif choice == "0"			
			@human_player.attacks(@enemies[0])
		elsif choice == "1"
			@human_player.attacks(@enemies[1])
		elsif choice == "2"
			@human_player.attacks(@enemies[2])
		end

		#Si jamais un Player est tué par le joueur humain
		@enemies.each do |player|
			if player.life_points < 0
				kill_player(player)
			end
		end				
	end

	############ENEMIES_ATTACKS######################
	def enemies_attack
		puts " "
		puts "Les autres joueur t'attaquent !"
		puts " "

		@enemies.each do |player|
			if player.life_points > 0
				player.attacks(@human_player)
			end	
		end
		puts " "
	end

	####################END########################
	def end
		if @human_player.life_points > 0
		puts "BRAVO ! TU AS GAGNE !"
	else
		puts "Loser ! Tu as perdu !"
	end
	end
end