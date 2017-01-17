require 'rails_helper'

RSpec.describe ToysController, type: :controller do

  let!(:pet) {Pet.create(name: "TonyTheTiger", breed: "GrrreAT", age: 47, cute: true)}
  let!(:toy) {Toy.create(description: "Sqeaker", pet: pet)}

  describe "GET #index" do
    it "assigns all toys as @toys" do
      get :index, params: {pet_id: pet.id}
      expect(assigns(:toys)).to eq(pet.toys)
    end
  end

end
