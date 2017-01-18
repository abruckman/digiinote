require 'spec_helper'

RSpec.describe SessionsController, type: :controller do

  


  describe "GET#oauth2" do 
    let(:credentials) { Google::Auth::UserRefreshCredentials.new(
     client_id: ENV['OAUTH'],
     client_secret: ENV['CLIENT_SECRET'],
     scope: [
       "https://www.googleapis.com/auth/drive",
       "https://spreadsheets.google.com/feeds/",

     ],
     redirect_uri:'http://localhost:3000/oauth2callback'
 ) }

    it "hit the oauth2 route" do 
      auth_url = credentials.authorization_uri

      get :save_google
      expect(response).to redirect_to(auth_url.to_s)

    end

  end

end
