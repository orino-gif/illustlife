class TestMailer < ApplicationMailer
  default from: 'illustlife.com <test@illustlife.com>' #example.comに自分のドメインを追加

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.test.subject
  #
  def test
    @greeting = "Hi"

    mail to: "xr274375@fc5.so-net.ne.jp"
  end
end
