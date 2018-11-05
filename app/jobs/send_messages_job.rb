class SendMessagesJob < ApplicationJob
  queue_as :default

  # checking message delivery after worker finished it's job
  # need refactoring
  after_perform do |check|

    # add delivery status and send custom message to log file
    add_status = lambda do |room, s|
      status = Article.find(@article_id)
      if room == 'Hipchat'
        status.hipchat_status = "#{s}"
      elsif room == 'Slack'
        status.slack_status = "#{s}"
      elsif room == 'Telegram'
        status.telegram_status = "#{s}"
      end
      status.save
      puts "Article(#{@article_id}) => #{room} - #{s}"
    end

    # searching article in messenger, if exists, not exists or skipped, call lambda add_status
    check_delivery = lambda do |room|
      if room.exists?(article_id:@article_id)
        add_status.call("#{room}", 'delivered')
      else
        if @message.messengers.include? "#{room}"
          add_status.call("#{room}", 'not delivered')
        else
          add_status.call("#{room}", 'skipped')
        end
      end
    end

    # choosing messengers, checking delivery and adding statuses
    check_delivery.call(Telegram)
    check_delivery.call(Slack)
    check_delivery.call(Hipchat)
  end

  def perform(*args)

    # sending messages to messengers
    send_message = lambda do |room|
      m = room.new
      m.title = @title
      m.description = @description
      m.author = User.find(@user_id).username
      m.article_id = args[0]
      m.save
    end

    # searching article
    @message = Article.find(args[0])

    # searching article user_id
    @user_id = @message.user_id

    # searching article_id
    @article_id = @message.id

    # searching user
    user = User.find(@user_id)

    # checking user verification
    if user.verification

      # searching title and description
      @title = @message.title
      @description = @message.description

      # validates one more time title and description
      if !@title.empty? && !@description.empty?

        # detecting messengers in which we should send messages and call lambda 'send_message'
        send_message.call(Telegram) if @message.messengers.include? 'Telegram'
        send_message.call(Slack) if @message.messengers.include? 'Slack'
        send_message.call(Hipchat) if @message.messengers.include? 'Hipchat'
      else

        # custom error if validation failed, we can inspect this error in log
        puts "WARN: An article(#{@message.id}) title or description is empty"
      end
    else

      # custom error if verification failed, we can inspect this error in log
      puts "WARN: user(#{user.id}) is not verified"
    end
  end

end
