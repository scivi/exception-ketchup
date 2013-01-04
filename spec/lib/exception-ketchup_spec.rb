require 'spec_helper'

describe Ketchup::Exception do

  it { should respond_to(:setup) }
  it { should respond_to(:environment) }
  it { should respond_to(:subject) }
  it { should respond_to(:template_path) }
  it { should respond_to(:deliver_mail) }
  it { should respond_to(:persist) }
  it { should respond_to(:recipients) }
  it { should respond_to(:template_path) }
  it { should respond_to(:template_path) }
  it { should respond_to(:exception_collection) }

  context "default configuration" do

    context "for environment" do

      it "is production" do
        subject.environment.should eq :production
      end

    end

    context "for mailing" do

      it "is enabled" do
        subject.deliver_mail.should be true
      end

    end

    context "to store errors" do

      it "is errors collection" do
        subject.exception_collection.should == :errors
      end

    end

  end

end