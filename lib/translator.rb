require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class Translator
    def initialize( texto ,codigo, idiomafinal)
        @texto = texto
        @codigo = codigo
        @idiomafinal = idiomafinal
    end

    def traducao
        url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2")
    
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Post.new(url)
        request["content-type"] = 'application/x-www-form-urlencoded'
        request["accept-encoding"] = 'application/gzip'
        request["x-rapidapi-key"] = '272f58ab42msh3ae30cfbf51280fp1afdddjsna6b09ea6e931'
        request["x-rapidapi-host"] = 'google-translate1.p.rapidapi.com'
        request.body = "q=#{@texto}&target=#{@idiomafinal}&source=#{@codigo}"
        
        response = http.request(request)
        response.read_body
    end

    def traduzir
        traduzir = JSON.parse(traducao)
        traduzir["data"]["translations"][0]["translatedText"]
    end
    
end

class SalvarTxt
    def initialize( texto , textotraduzido)
        @texto = texto
        @textotraduzido = textotraduzido
    end 

    def gerar
        nomearquivo = Time.now.strftime('Texto traduzido dia %d-%m-%y ás %H-%M')
        File.open(nomearquivo + '.txt', 'a') do |line|
            line.puts "Texto inserido: #{@texto}. \n Texto traduzido: #{@textotraduzido}"
        end
        p nomearquivo + ".txt"
    end

end