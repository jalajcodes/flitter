require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "Full title helper" do
    assert_equal full_title, "Flitter"
    assert_equal full_title("Help"), "Help | Flitter"
  end
end
