require 'test_helper'
require 'faker'
class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
    @user = users(:blank)
  end
  test "A user should have a name" do
    user = User.new(email: Faker::Internet.email,
                    password: "password",
                    password_confirmation: "password")
    assert_not user.save, "The user object is not valid"
  end

  test "associated decks should be destroyed" do 
    @user.save
    assert_difference "Deck.count", 1 do
      @user.decks.create(name: "test",option: options(:one))
    end
    assert_difference "Deck.count", -1 do
      @user.destroy
    end
  end
end
