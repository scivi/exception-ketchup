require "spec_helper"

describe Ketchup::Exception::Mailer do
  let(:recipients){ %W(ds@test.com da@test.com) }

  before do 
    Ketchup::Exception.setup do |config|
      config.subject = "Test Error"
      config.recipients = recipients
      config.sender = "foo@example.com"
      config.template_path = "notifications"
    end
  end

  describe 'notifications' do
    let(:error) do 
      double("error", :message => "Tiny test error",
             :backtrace => ["error at line 10", "wrong arguments: 1 for 0"])

    end
    let(:host){ "http://example.com"}
    let(:mail){ Ketchup::Exception::Mailer.notification_email(error,host) }

    it "renders the subject" do
      mail.subject.should eq "Test Error"
    end

    it "renders the receiver mail" do
      mail.to.should == recipients
    end

    it "renders the senders email" do
      mail.from.should == [Ketchup::Exception.sender]
    end

    it "assigns @message" do
      mail.body.encoded.should match(error.message)
    end

    it "assigns @host" do
      mail.body.encoded.should match(host)
    end

  end

end