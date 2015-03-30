require "spec_helper"

describe PagSeguro::Session do
  let(:session) { PagSeguro::Session.new }
  subject { session }

  before do
    PagSeguro.config.email = 'mail'
    PagSeguro.config.token = 'token'
  end

  it { should respond_to(:create) }

  describe "#create" do
    subject { session.create  }

    context 'with default email and token' do
      before do
        stub_request(:post, "https://ws.pagseguro.uol.com.br/v2/sessions").
           with(body: "email=mail&token=token").to_return(status: 200)
      end

      it { should be_a_kind_of(PagSeguro::Session::Response) }
    end

    context 'with alternative email and token' do
      subject { session.create('alternative')  }
      before do
        stub_request(:post, "https://ws.pagseguro.uol.com.br/v2/sessions").
           with(body: "email=alt_mail&token=alt_token").to_return(status: 200)
      end

      it { should be_a_kind_of(PagSeguro::Session::Response) }
    end
  end
end
