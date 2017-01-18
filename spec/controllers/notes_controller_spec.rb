##################################################
##################################################
##########    DO NOT MODIFY THIS FILE   ##########
##################################################
##################################################

require 'spec_helper'
 
RSpec.describe NotesController, type: :controller do

  let(:valid_attributes) {
    {title: "TonyTheTiger", text: "GrrreAT"}
  }

  let(:invalid_attributes) {
    {name: nil}
  }

  describe "GET #index" do
    render_views

    it "renders index view" do
      get :index
      expect(response).to render_template("index")
    end

    it "renders new form" do 
      get :index
      response.should render_template(:partial => '_new')
    end

    it "works!" do 
      get :index
      response.status.should be(200)
    end
  end

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
