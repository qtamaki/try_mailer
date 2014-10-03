class NoticeMailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  def sendmail_confirm(send_to)
    @greeting = "Hi"

    mail to: send_to
  end

  def NoticeMailer.setup(user, passwd)
    default from: user
    ActionMailer::Base.smtp_settings = {
      :enable_starttls_auto => true,
      :address => 'smtp.gmail.com',
      :port => 587, # 25 or 465
      :domain => user.split("@")[1],
      :authentication => 'plain',
      :user_name => user,
      :password => passwd
    }
  end

  def change_and_send(a,b,c)
    old_setting = ActionMailer::Base.smtp_settings
    setup(a, b)
    begin
      NoticeMailer.sendmail_confirm(c).deliver
    ensure
      ActionMailer::Base.smtp_settings = old_setting
    end
  end

end

# 
# NoticeMailer.setup('hogehoge@gmail.com','xxxxxxxx')
# NoticeMailer.sendmail_confirm('fugafuga@gmail.com').deliver
#

# message = 'ああああああああああああああああああああ'
# secret = SecureRandom::hex(50) #環境変数で渡す ENV["SMTP_SECRET_KEY"]
# encryptor = ::ActiveSupport::MessageEncryptor.new(secret, cipher: 'aes-256-cbc')
#
# #encrypt_message = encryptor.encrypt_and_sign(message)
# encrypt_message = encryptor.encrypt(message)
# encryptor.decrypt_and_verify(encrypt_message)
#
#
