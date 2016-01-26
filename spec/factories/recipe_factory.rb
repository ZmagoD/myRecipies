require 'faker'

FactoryGirl.define do
    
  factory :chef do
    name "John" 
    email { Faker::Internet.email }
    password "asdf1234"
    confirmed_at "2016-01-01 10:00:00"
  end
  
  factory :recipe do
    name "Pasta"
    summary "Super cool pasta with pomodoro and parmigano cheese"
    description "Boil the water add salt add pasta cook 10 minutes dry it add pomodoro.."
    association :chef, factory: :chef
  end 
  
end