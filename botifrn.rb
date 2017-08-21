require 'telegram/bot'

#comandos = ['/start','/local','/site']
comandos = [
    {
      'nome' => "/start",
      'funcao' => 'Eu me apresento para você!'
    },
    {
      'nome' => "/local",
      'funcao' => 'Irei mostrar para você as localidades do IFRN'
    },
    {
      'nome' => "/site",
      'funcao' => 'Vou informar qual é o site geral do IFRN'
    },
    {
      'nome' => "/polos",
      'funcao' => 'Vou informar todos os polos do IFRN e suas localidades'
    },
    {
      'nome' => "/horarios",
      'funcao' => 'Vou informar os horários de abertura e fechamento do IFRN'
    },
    {
      'nome' => "/fone",
      'funcao' => 'Telefone da secretária geral do IFRN'
    },



]

frase_comandos = "Os meus comandos são:\n"
token = '433028524:AAHEy9rqu1smf1ic0Xq9UN8dAttGqwBAhls'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Seja-bem vindo ao Assistente do IFRN, em que posso ajuda-lo ?\nUse o comando /help para ver o que posso fazer por você")
      #  bot.api.send_message(chat_id: message.chat.id, text: "")
    when '/local'
      bot.api.send_message(chat_id: message.chat.id, text: "O IFRN campus de Natal na Salgado Filho se encontra: Av. Sen. Salgado Filho, 1559 - Tirol, Natal - RN, CEP:59015-000")
      bot.api.send_location(chat_id: message.chat.id, latitude: -5.8118082, longitude: -35.2034515)
    when '/help'
    #  bot.api.send_message(chat_id: message.chat.id, text: "Os meus comandos são:")

          i=0
          comandos.each { |comando|

            cmd = []
            comando.each {|k,v|
                cmd.push(v)
                if i == 1
                    #bot.api.send_message(chat_id: message.chat.id, text: cmd[0] + " - "+ cmd[1] )

                    frase_comandos.concat(cmd[0]+" - "+cmd[1]+"\n")
                    i = 0
                else
                    i = i + 1
                end
            }
          }
          bot.api.send_message(chat_id: message.chat.id, text: frase_comandos )

        when '/site'
          bot.api.send_message(chat_id: message.chat.id, text: "Nosso site é: http://portal.ifrn.edu.br/")
        when '/horarios'
          bot.api.send_message(chat_id: message.chat.id, text: "Horário de Atendimento:")
        when '/fone'
          bot.api.send_message(chat_id: message.chat.id, text: "Telefone:")
        when '/polos'
          question = 'Escola um polo:'
        answers =
          Telegram::Bot::Types::ReplyKeyboardMarkup.new(
          keyboard: [
            ["Apodi", "Caicó", "Canguaretama"],
            ["Ceará-Mirim", "Currais Novos", "Ipanguaçu"],
            ["João Câmara", "Lajes", "Macau"],
            ["Mossoró", "/Natal", "Nova Cruz"],
            ["Parelhas", "Parnamirim", "Pau dos Ferros"],
            ["Santa Cruz", "São Gonçalo do Amarante", "São Paulo do Potengi"],
            ["", "Educação a Distância (EAD)",""]
          ],

          one_time_keyboard: true
          )

          bot.api.sendMessage(chat_id: message.chat.id, text: question, reply_markup: answers)
          #message.text = answers
    end
  end
end
