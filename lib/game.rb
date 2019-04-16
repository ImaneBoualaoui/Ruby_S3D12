require 'pry'
require_relative 'player'

class Game
	attr_accessor :human_player, :enemies, :player_left, :enemies_in_sight
 	
 	################INITIALISATION###########################
	def initialize(name)
		#pour la version 3 
		@enemies = []
		player1 = Player.new("Ennemis1")
		@enemies.push(player1)
		player2 = Player.new("Ennemis2")
		@enemies.push(player2)
		player3 = Player.new("Ennemis3")
		@enemies.push(player3)

		@human_player = HumanPlayer.new(name)

		#pour la version 3 : quelques fonctionnalités en plus
		@player_left = 10 # modélise le nombre de joeur restant dans le jeu
		@enemies_in_sight = []
	end

	#######################KILL#############################
	def kill_player(player)
		#@enemies.delete(player)
		@enemies_in_sight.delete(player)
		#à chaque joueur tué je fais -1
		@player_left -=1
	end

	#################STILL_ON_GOING#########################
	def is_still_ongoing?
		return @human_player.life_points > 0 && player_left != 0
	end

	#####################SHOW_PLAYERS#######################
	def show_players
		puts "Voici l'état du joueur humain :"
		@human_player.show_state
		puts "Voici le nombre de joueurs bots restant :"
		#puts @enemies.size
		puts @enemies_in_sight.size
		puts " "
	end

	##########################MENU#######################
	def menu
		puts "Voici l'état de chaque joueur :"
		@human_player.show_state
		# @enemies.each do |player|
		# 	player.show_state
		# end
		@enemies_in_sight.each do |player|
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
		# @enemies.each do |player|
		# 	print "#{i}- " 
		# 	player.show_state
		# 	i +=1
		# end
		@enemies_in_sight.each do |player|
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
		end
		
		i = 0

		#je fais une boucle sur chaque ennemis car on pourrait en avoir plus de 3
		# @enemies.each do |player|
		# 	if choice == "#{i}"
		# 		@human_player.attacks(player)
		# 	end
		# 	#Si jamais un Player est tué par le joueur humain
		# 	if player.life_points < 0
		# 		kill_player(player)
		# 	end

		# 	i +=1
		# end		
		@enemies_in_sight.each do |player|
			if choice == "#{i}"
				@human_player.attacks(player)
			end
			#Si jamais un Player est tué par le joueur humain
			if player.life_points < 0
				kill_player(player)
			end

			i +=1
		end				
	end

	############ENEMIES_ATTACKS######################
	def enemies_attack
		puts " "
		puts "Les autres joueur t'attaquent !"
		puts " "

		# @enemies.each do |player|
		# 	if player.life_points > 0
		# 		player.attacks(@human_player)
		# 	end	
		# end
		# puts " "

		@enemies_in_sight.each do |player|
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
	
	###################NEW_PLAYERS#################
	def new_players_in_sight
		#si tout le monde en vie, on ne rajoute personne, donc au départ 4 joueurs
		if @human_player.life_points > 0 && @enemies_in_sight.size == 3
			puts "Tous les joueurs sont déjà en vue"
		else
			#on lance un dé
			dice = rand(1..6)

			if dice == 1
				puts " Aucun nouveau joeur adverse n'arrive"
			elsif dice == 2 || dice == 3 || dice == 4
				number = rand(1..10000)
				new = Player.new("Ennemis_#{number}")
				puts "Un nouveau adversaire est arrivé : #{new.name}"
				#on ajoute ce nouvel adversaire en vue dans notre array
				@enemies_in_sight.push(new)
			else
				number1 = rand(1..10000)
				number2 = rand(1..10000)
				new1 = Player.new("Ennemis_#{number1}")
				new2 = Player.new("Ennemis_#{number2}")
				puts "Deux nouveaux adversairex sont arrivés : #{new1.name} et #{new2.name}"
				#on ajoute les 2 nouveaux adversaire en vue dans notre array
				@enemies_in_sight.push(new1)
				@enemies_in_sight.push(new2)
			end	
		end
	end
end