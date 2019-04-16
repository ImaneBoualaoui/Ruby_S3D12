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

	my_game = Game.new(name_player)

	while my_game.is_still_ongoing?
		my_game.show_players
		my_game.menu
		my_game.menu_choice
		my_game.enemies_attack
	end
	my_game.end
end

game
binding.pry