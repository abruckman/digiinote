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

  describe 'GET '

 
end
