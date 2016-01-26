require 'rails_helper'

RSpec.feature 'Search recipe' do
    
    before do
       create :recipe
       create :recipe, name: "Pizza", summary: "The best pizza in town"
       visit "/"
    end
    
    scenario "with no input" do
       fill_in 'search_recipe', with: ''
       click_button 'Išči recept'
       
       expect(page).to have_content( "Super cool pasta with pomodoro and parmigano cheese" )
    end
    
    scenario "with input" do
       fill_in 'search_recipe', with: 'Pizza'
       click_button 'Išči recept'
       expect(page).to_not have_content( "Super cool pasta with pomodoro and parmigano cheese" )
       expect(page).to have_content( "Pizza" )
       expect(page).to have_content( "The best pizza in town" )
    end
    
    scenario "find multiple recipes" do
        5.times { create :recipe, name: "Tacos"} 
        fill_in 'search_recipe', with: "Tacos"
        click_button 'Išči recept'
        
        expect(page).to have_content("Tacos", count: 5)
       
    end
end