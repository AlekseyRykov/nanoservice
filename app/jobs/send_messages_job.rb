class SendMessagesJob < ApplicationJob
  queue_as :default

  def perform(*args)

    send_message = lambda do |room|
      m = room.new
      m.title = @title
      m.description = @description
      m.author = User.find(@id).username
      m.article_id = args[0]
      m.save
    end

    message = Article.find(args[0])
    @id = message.user_id

    if User.find(@id).verification == 'false'

      @title = message.title
      @description = message.description

      if !@title.empty? && !@description.empty?
        send_message.call(Telegram) if message.messengers.include? 'Telegram'
        send_message.call(Slack) if message.messengers.include? 'Slack'
        send_message.call(Hipchat) if message.messengers.include? 'HipChat'
      else
        puts 'WARN: title or description is empty'
      end
    else
      puts 'WARN: user is not verified'
    end
  end
end
