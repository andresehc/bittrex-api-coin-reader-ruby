require_relative 'coins'

def main
	puts "Introduce la moneda que deseas mostrar"
	moneda = gets.chomp.upcase
	puts "Introduce la base de la moneda que deseas mostrar"
	base = gets.chomp.upcase
	joined_ticker = "#{base}-#{moneda}"
	Coins.actions(joined_ticker)
end

main