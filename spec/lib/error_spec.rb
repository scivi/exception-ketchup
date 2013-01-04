require 'spec_helper'

describe Ketchup::Exception::Error do

  it{should respond_to(:kind)}
  it{should respond_to(:backtrace)}
  it{should respond_to(:happend_at)}
  it{should respond_to(:message)}

  context "#kind" do

    let(:exception){ StandardError.new("something happened") }
    let(:error){ Ketchup::Exception::Error.new }

    before do
      error.kind = exception.class.name
      error.backtrace = exception.backtrace
      error.message = exception.message
      error.happend_at = Time.now
      error.save
    end

    subject{Ketchup::Exception::Error.last}

    its(:kind){should eq "StandardError"}

  end

end