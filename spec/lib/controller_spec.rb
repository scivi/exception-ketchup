require 'spec_helper'

FakeTestController = Class.new(ApplicationController) do

  respond_to :json

  ketchup_exceptions do |c|
    c.rescue_errors = [
      { :error => Mongoid::Errors::DocumentNotFound, :with => :document_not_found } ,
      { :error => ArgumentError, :with => :document_not_found} 
    ]
  end

  def operation_failed(error)
    respond_with({:error => "Operation could not be operated."})
  end

  def document_not_found(error)
    respond_with({:error => "Operation could not be operated."})
  end

  def respond_with_error(error)
    document_not_found(error)
  end

  def show
    @author = Author.find(params[:id])
    respond_with @author
  end

end

Rails.application.routes.draw do
  match '/show_author/:id' => "fake_test#show"
end


describe "exception handling within controller", :type => :controller do
  let(:recipients){ %W(ds@test.com da@test.com) }

  before do 
    Ketchup::Exception.setup do |config|
      config.subject = "Test Error"
      config.recipients = recipients
      config.sender = "foo@example.com"
      config.template_path = "notifications"
      config.environment = :test
    end

    mongo_major = Mongoid::VERSION.split(".").first

    unless defined?(Author)
      Author = Class.new do
        include Mongoid::Document
        if mongo_major.eql?("3")
          store_in :collection => :authors
        else
          store_in :authors
        end
      end
    end

  end

  describe FakeTestController do 

    before do
      @controller = FakeTestController.new
    end

    it "handles with custom method" do
      Author.should_receive(:find).and_raise(Mongoid::Errors::DocumentNotFound)
      expect do 
        get :show, :id => "50e3f7e6f1a8f299cb000001" , :format => "json" 
      end.to change(ActionMailer::Base.deliveries, :size).by(1)
      result = ActiveSupport::JSON.decode(response.body)
      result.should have_key("error")
    end

    context "mailing is disabled" do
      before do
        Ketchup::Exception.setup do |config|
          config.subject = "Test Error"
          config.recipients = recipients
          config.sender = "foo@example.com"
          config.template_path = "notifications"
          config.deliver_mail = false
          config.environment = :test
        end

      end
    
      it "did not send mails" do
        Author.should_receive(:find).any_number_of_times.and_raise(Mongoid::Errors::DocumentNotFound)
        expect do 
          get :show, :id => "50e3f7e6f1a8f299cb000001" , :format => "json" 
        end.to_not change(ActionMailer::Base.deliveries, :size).by(1)
        expect do 
          get :show, :id => "50e3f7e6f1a8f299cb000001" , :format => "json" 
        end.to change(Ketchup::Exception::Error, :count).by(1)
      end
    end

    context "persist to database if disabled" do

      before do
        Ketchup::Exception.setup do |config|
          config.subject = "Test Error"
          config.recipients = recipients
          config.sender = "foo@example.com"
          config.template_path = "notifications"
          config.persist = false
          config.environment = :test
        end
      end

      it "did not save to db" do
        Author.should_receive(:find).any_number_of_times.and_raise(Mongoid::Errors::DocumentNotFound)
        expect do 
          get :show, :id => "50e3f7e6f1a8f299cb000001" , :format => "json" 
        end.to_not change(Ketchup::Exception::Error, :count).by(1)
      end
    end
  end
end