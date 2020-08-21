numeros_digitados = []

variavel = 0
variaveis_digitadas = []

puts "Digite"

# while variavel != "pare"
#     variavel = gets.strip
#     break if variavel == "pare"
#     soma = 0
#     variaveis_digitadas << variavel
#     for numero in variaveis_digitadas
#         soma += numero.to_i
#     end
#     puts "A soma de todos os números digitadios até agora é: #{soma}"
#     puts "Os números que você digitou até agora são: #{variaveis_digitadas}"
# end

# #jeito vini
# loop do
#     variavel = gets.strip
#     break if variavel == "pare"

#     variaveis_digitadas << variavel.to_i
#     soma = variaveis_digitadas.reduce(:+)

#     puts "A soma de todos os números digitadios até agora é: #{soma}"
#     puts "Os números que você digitou até agora são: #{variaveis_digitadas}"
# end

#jeito vini 2 sem precisar do array
soma = 0
loop do
    variavel = gets.strip
    break if variavel == "pare"

    soma += variavel.to_i

    puts "A soma de todos os números digitadios até agora é: #{soma}"
end


# loop do
#     puts "Digite um número:"
#     numeros_digitados << gets.to_i
#     puts "Soma dos números digitados: #{}"
# end