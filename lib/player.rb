require 'pry'

class Player
	attr_accessor :name, :life_points

	def initialize(name)
		@name = name
		@life_points = 10
	end

	#Méthode qui afficha l'état d'un joueur
	def show_state
		puts @name + " a #{life_points} points de vie"
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