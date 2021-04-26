require 'uri'
require 'net/http'
require 'openssl'
require 'json'

puts 'Digite algum texto para tradução'
texto = gets.chomp
puts 'Digite o idioma do texto, en, es, pt'
idioma = gets.chomp
puts 'Digite para qual idioma deseja traduzir o texto, en, es, pt '
idioma_traducao = gets.chomp




   class Traducao
    def salvar_arquivo(texto, idioma, idioma_traducao, traducao_final)
        File.open(Time.now.strftime("%d-%m-%y_%H-%M.txt"), 'a') do |line|
            line.puts" a palavra "+texto
            line.puts "em " +idioma
            line.puts " é traduzida para o idioma " +idioma_traducao+" da seguinte forma"
            line.puts traducao_final
        end
    end
    def traduzir(texto, idioma, idioma_traducao)
        url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Post.new(url)
        request["content-type"] = 'application/x-www-form-urlencoded'
        request["accept-encoding"] = 'application/gzip'
        request["x-rapidapi-key"] = '4765f17c08msh2a1ba2526291bfcp1bf3a7jsne35b478935b3'
        request["x-rapidapi-host"] = 'google-translate1.p.rapidapi.com'
        request.body = "q=#{texto}&target=#{idioma_traducao}&source=#{idioma}"
        
        response = http.request(request)
        traducao = response.read_body
        hash_traducao = JSON.parse(traducao)
        hash_traducao['data']['translations'][0]['translatedText']

    end
   end


   traducao = Traducao.new
   traducao_final = traducao.traduzir(texto, idioma, idioma_traducao)
   traducao.salvar_arquivo(texto, idioma, idioma_traducao, traducao_final)