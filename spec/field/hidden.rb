class FieldHiddenTest < Test::Unit::TestCase
  def test_empty_hidden_field
    field = Reform::Field::Hidden.new
    doc = Nokogiri.parse(field.to_s)

    # There is one and only one input tag
    assert_equal(1, doc.css("input").size)
    input = doc.css("input").first

    # Input is of type "hidden"
    assert_equal("hidden", input.attr("type"))

    # Unspecified attributes do not exist
    assert_equal(nil, input.attr("id"))
    assert_equal(nil, input.attr("name"))
    assert_equal(nil, input.attr("value"))
  end

  def test_attributes
    name = "some_name"
    value = "some_value"
    id = "some_id"

    field = Reform::Field::Hidden.new({
      :name => name,
      :value => value,
      :id => id,
    })
    doc = Nokogiri.parse(field.to_s)

    # There is one and only one input tag
    assert_equal(1, doc.css("input").size)
    input = doc.css("input").first

    # Input is of type "text"
    assert_equal("hidden", input.attr("type"))

    # All the attributes are set correctly
    assert_equal(id, input.attr("id"))
    assert_equal(name, input.attr("name"))
    assert_equal(value, input.attr("value"))
  end
end

