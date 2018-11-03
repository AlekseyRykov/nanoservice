class SendMessagesJob < ApplicationJob
  queue_as :default

  after_perform do |check|

    if Hipchat.exists?(article_id:@article_id)
      status = Article.find(@article_id)
      status.hipchat_status = "Delivered"
      status.save
      puts "Article(#{@article_id}) delivered to hipchat"
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

    send_message = lambda do |room|
      m = room.new
      m.title = @title
      m.description = @description
      m.author = User.find(@user_id).username
      m.article_id = args[0]
      m.save
    end

    @message = Article.find(args[0])
    @user_id = @message.user_id
    @article_id = @message.id

    user = User.find(@user_id)

    if user.verification
      @title = @message.title
      @description = @message.description

      if !@title.empty? && !@description.empty?
        send_message.call(Telegram) if @message.messengers.include? 'Telegram'
        send_message.call(Slack) if @message.messengers.include? 'Slack'
        send_message.call(Hipchat) if @message.messengers.include? 'Hipchat'
      else
        puts "WARN: An article(#{@message.id}) title or description is empty"
      end
    else
      puts "WARN: user(#{user.id}) is not verified"
    end
  end

end
