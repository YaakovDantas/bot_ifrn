require 'telegram/bot'

#comandos = ['/start','/local','/site']
comandos = [
    {
      'nome' => "/start",
      'funcao' => 'Eu me apresento para você! :D'
    },
    {
      'nome' => "/local",
      'funcao' => 'Irei mostrar para você as localidades do IFRN'
    },
    {
      'nome' => "/site",
      'funcao' => 'Vou informar qual é o site geral do IFRN'
    }


]


token = '433028524:AAHEy9rqu1smf1ic0Xq9UN8dAttGqwBAhls'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Seja-bem vindo ao Assistente do IFRN, em que posso ajuda-lo ?")
        bot.api.send_message(chat_id: message.chat.id, text: "Use o comando /help para ver o que posso fazer por você")
    when '/local'
      bot.api.send_message(chat_id: message.chat.id, text: "O IFRN campus de Natal na Salgado Filho se encontra: Av. Sen. Salgado Filho, 1559 - Tirol, Natal - RN, CEP:59015-000")
      bot.api.send_location(chat_id: message.chat.id, latitude: -5.8118082, longitude: -35.2034515)
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, text: "Os meus comandos são:")

    i=0
    comandos.each { |comando|

      cmd = []
      comando.each {|k,v|
          cmd.push(v)

          if i == 1
              bot.api.send_message(chat_id: message.chat.id, text: cmd[0] + " - "+ cmd[1] )
              i = 0
          else
              i = i + 1
          end
      }
    }


    when '/site'
        bot.api.send_message(chat_id: message.chat.id, text: "Nosso site é: http://portal.ifrn.edu.br/")
    end
  end
end
