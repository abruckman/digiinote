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

  end

  # describe "GET #new" do 
  #   it "click take a picture and hides form " do

  #     click_link('Take a Picture')
  #     expect(response).to render_template("new")
  #   end
  # end

  # describe "GET #show" do
  #   it "assigns the requested pet as @pet" do
  #     pet = Pet.create! valid_attributes
  #     get :show, params: {id: pet.to_param}
  #     expect(assigns(:pet)).to eq(pet)
  #   end
  # end

  # describe "GET #edit" do
  #   it "assigns the requested pet as @pet" do
  #     pet = Pet.create! valid_attributes
  #     get :edit, params: {id: pet.to_param}
  #     expect(assigns(:pet)).to eq(pet)
  #   end
  # end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       {name: "TonyTheTiger", breed: "GrrreAT", age: 48, cute: true}
  #     }

  #     it "assigns the requested pet as @pet" do
  #       pet = Pet.create! valid_attributes
  #       put :update, params: {id: pet.to_param, pet: new_attributes}
  #       expect(assigns(:pet)).to eq(pet)
  #     end

  #     it "redirects to the pet" do
  #       pet = Pet.create! valid_attributes
  #       put :update, params: {id: pet.to_param, pet: new_attributes}
  #       expect(response).to redirect_to(pet)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns the pet as @pet" do
  #       pet = Pet.create! valid_attributes
  #       put :update, params: {id: pet.to_param, pet: invalid_attributes}
  #       expect(assigns(:pet)).to eq(pet)
  #     end

  #     it "re-renders the 'edit' template" do
  #       pet = Pet.create! valid_attributes
  #       put :update, params: {id: pet.to_param, pet: invalid_attributes}
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end

end
