
class DeclareTest < Test::Unit::TestCase
  def test_empty_form
    assert_equal([], EmptyForm.fields)
  end

  def test_simple_form
    assert_equal(
      [[Reform::Field::Text, {:name=>"name", :id=>"SimpleForm_name"}]],
      SimpleForm.fields
    )
  end
end
