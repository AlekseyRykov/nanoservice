class SendMessagesJob < ApplicationJob
  queue_as :default

  # checking message delivery after worker finished it's job
  # need refactoring
  after_perform do |check|

    # searching article in messenger, if exists, add status and send custom message to log file
    if Hipchat.exists?(article_id:@article_id)
      status = Article.find(@article_id)
      status.hipchat_status = "Delivered"
      status.save
      puts "Article(#{@article_id}) delivered to hipchat"

    # searching article in messenger, if not exists or skipped, add status and send custom message to log file
    else
      status = Article.find(@article_id)
      if @message.messengers.include? 'Hipchat'
        status.hipchat_status = "Not delivered"
        status.save
        puts "Article(#{@article_id}) not delivered to hipchat"
      elsif !@message.messengers.include? 'Hipchat'
        status.hipchat_status = "Skipped"
        status.save
        puts "Article(#{@article_id}) skipped for hipchat"
      end
    end

    # same logic as for hipchat
    if Slack.exists?(article_id:@article_id)
      status = Article.find(@article_id)
      status.slack_status = "Delivered"
      status.save
      puts "Article(#{@article_id}) delivered to slack"
    else
      status = Article.find(@article_id)
      if @message.messengers.include? 'Slack'
        status.slack_status = "Not delivered"
        status.save
        puts "Article(#{@article_id}) not delivered to slack"
      elsif !@message.messengers.include? 'Slack'
        status.slack_status = "Skipped"
        status.save
        puts "Article(#{@article_id}) skipped for slack"
      end
    end

    # same logic as for hipchat
    if Telegram.exists?(article_id:@article_id)
      status = Article.find(@article_id)
      status.telegram_status = "Delivered"
      status.save
      puts "Article(#{@article_id}) delivered to telegram"
    else
      status = Article.find(@article_id)
      if @message.messengers.include? 'Telegram'
        status.telegram_status = "Not delivered"
        status.save
        puts "Article(#{@article_id}) not delivered to telegram"
      elsif !@message.messengers.include? 'Telegram'
        status.telegram_status = "Skipped"
        status.save
        puts "Article(#{@article_id}) skipped for telegram"
      end
    end
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
