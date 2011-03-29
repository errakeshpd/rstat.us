require_relative "test_helper"

class AuthorTest < MiniTest::Unit::TestCase

  include TestHelper

  def setup
    @author = Factory.build :author, :username => "james", :email => nil, :image_url => nil
  end

  def test_create_from_hash
    hash = {"user_info" => {"name" => "james", "nickname" => "jim", "urls" => {}} }
    assert Author.create_from_hash!(hash).is_a?(Author)
  end

  def test_url
    @author.remote_url = "some_url.com"
    assert_equal @author.remote_url, @author.url
  end

  def test_valid_avatar_url
    @author.email = "jamecook@gmail.com"
    assert_equal @author.gravatar_url, @author.avatar_url
  end

  def test_invalid_avatar_url
    @author.email = "completely@invalid-email.asdfasd.com"
    assert_equal "/images/avatar.png", @author.avatar_url
  end
end
