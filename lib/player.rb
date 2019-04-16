require 'pry'

class Player
	attr_accessor :name, :life_points

	def initialize(name)
		@name = name
		@life_points = 10
	end

	#Méthode qui afficha l'état d'un joueur
	def show_state
		puts @name + " a #{@life_points} points de vie"
	end

	#Méthode : subir une attaque
	def gets_damage(damage)
		
		#on soustrait au niveau de vie du joueur l'entier passer en paramètre
		@life_points = @life_points - damage

		#On vérifie si le joueur est mort
		if @life_points <= 0
			puts "Le joueur " + @name + " a été tué !"
		end
	end

	def compute_damage
		return rand(1..6)
	end

	def attacks(player2)
		puts "le joueur " + self.name + " attaque le joueur " + player2.name

		#on obtient un chiffre aléatoire avec la méthode compute_damage
		val = compute_damage

		puts "il lui inflige #{val} points de dommages"

		#on fait subir les dégâts à l'autre joueur avec en paramètre la valeur val
		player2.gets_damage(val)
	end
end

class HumanPlayer < Player
	attr_accessor :weapon_level

	def initialize(name)
		@name = name
		@life_points = 100
		@weapon_level = 1
	end

	def show_state
		puts @name +" a #{@life_points} points et une arme de niveau #{@weapon_level}"
	end

	def compute_damage
		rand(1..6) * @weapon_level
	end

	def search_weapon
		#Lancé de dé qui sera égal au niveau de la nouvelle arme trouvé
		dice = rand(1..6)
		puts "Tu as trouvé une arme de niveau #{dice}"

		#On cherche à savoir si l'arme vaut le coup ou pas
		if dice > @weapon_level
			@weapon_level = dice
			puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
		else
			puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
		end
	end

	def search_health_pack
		#on lance le dé
		dice = rand(1..6)

		if dice == 1
			puts "Tu n'as rien trouvé"
		elsif dice == 2 || dice == 3 || dice == 4 || dice == 5
			#si sa vie est inférieur ou égal à 50 on sait que sa vie ne dépassera pas 100 points
			if @life_points <= 50 
				@life_points += 50
			#Sinon on augmente sa vie en faisant attention de ne pas dépasser 100 points
			else 
				life = 100 - @life_points
				@life_points += life # donc on ne peut pas lui augmenter de 50 points mais uniquement des points qui lui manque pour avoir 100 points
			end
			puts "Bravo, tu as trouvé un pack de +50 points de vie !"
		else #même test qu'au dessus
			if @life_points <= 20 
				@life_points += 80
			else 
				life = 100 - @life_points
				@life_points += life
			end
			puts "Waow, tu trouvé un pack de +80 points de vie !"
		end			
	end
end