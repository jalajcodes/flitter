require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user =
      User.new(
        name: 'Jalaj',
        email: 'Jalaj@mail.com',
        password: 'foobar',
        password_confirmation: 'foobar'
      )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = "#{'a' * 244}@example.com"
    assert_not @user.valid?
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[
      user@example,com
      user_at_foo..org
      user.name@example.
      foo@bar_baz.com
      foo@bar+baz.com
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be saved as lowercase' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (not be blank)' do
    @user.password = @user.password_confirmation = '  ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return falase for a user with nil digest' do
    assert_not @user.authenticated?('')
  end

  test 'associated microposts should be destroyed' do
    @user.save
    @user.microposts.create!(content: 'Lorem ipsum')
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test 'feed should have the right posts' do
    michael = users(:test)
    archer = users(:archer)
    lana = users(:lana)

    # Posts from followed user
    lana.microposts.each { |post_following| assert michael.feed.include?(post_following) }

    # Self-posts for user with followers
    michael.microposts.each { |post_self| assert michael.feed.include?(post_self) }

    # Self-posts for user with no followers
    archer.microposts.each { |post_self| assert archer.feed.include?(post_self) }

    # Posts from unfollowed user
    archer.microposts.each { |post_unfollowed| assert_not michael.feed.include?(post_unfollowed) }
  end

  test 'should follow and unfollow a user' do
    user = users(:test)
    user2 = users(:test2)
    assert_not user.following?(user2)
    user.follow(user2)
    assert user.following?(user2)
    assert user2.followers.include?(user)
    user.unfollow(user2)
    assert_not user.following?(user2)

    # Users can't follow themselves.
    user.follow(user)
    assert_not user.following?(user)
  end
end
