require_relative 'lib/translator.rb'

puts 'Insira o texto a ser traduzido:'
texto = gets.chomp

puts 'Insira o codigo do idioma atual: pt , en , es , fr, de'
codigo = gets.chomp
puts

puts 'Insira o codigo do idioma para o qual será traduzido:'
idiomafinal = gets.chomp

translate = Translator.new(texto , codigo ,idiomafinal)

textotraduzido = translate.traduzir

arquivo = SalvarTxt.new(texto , textotraduzido).gerar

puts "A tradução é: #{translate.traducao} "