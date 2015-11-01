require 'test_helper'

class ChefTest < ActiveSupport::TestCase 
   
    def setup
        @chef = Chef.new( name: "John", email: "Jhon@example.com" )
    end
    
    test "chef should be valid" do 
        assert @chef.valid?
    end
    
    test "chef name should be present" do
        @chef.name = " "
        assert_not @chef.valid?
    end
    
    test "chef name should not be too long" do
        @chef.name = "a" * 41
        assert_not @chef.valid?
    end
    
    test "chef name should not be too short" do
        @chef.name = "aa"
        assert_not @chef.valid?        
    end
    
    test "chef email shoud be present" do
       @chef.email = " "
       assert_not @chef.valid?
    end
    
    test "chef email shoud not be too long" do 
        @chef.email = "a" * 101 + "@exampe.com"
        assert_not @chef.valid?
    end
    
    test "email address should be unique" do
        chef_dup = @chef.dup
        chef_dup.email = @chef.email.upcase
        @chef.save
        assert_not chef_dup.valid?
    end
    
    test "email validation should acceppt valid addresses" do
        valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
        valid_addresses.each do |va|
            @chef.email = va
            assert @chef.valid?, "#{va.inspect} should be valid"
        end
    end
    
    test "email validation should reject valid addresses" do
        invalid_addresses = %w[ user@example,com user_att_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
        invalid_addresses.each do |inv|
           @chef.email = inv
           assert_not @chef.valid?, "#{inv.inspect} should be invalid"
        end
    end
end