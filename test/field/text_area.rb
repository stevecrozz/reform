class FieldTextAreaTest < Test::Unit::TestCase
  def test_empty_text_field
    field = Reform::Field::TextArea.new
    doc = Nokogiri.parse(field.to_s)

    # There is one and only one textarea tag
    assert_equal(1, doc.css("textarea").size)
    textarea = doc.css("textarea").first

    # Unspecified attributes do not exist
    assert_equal(nil, textarea.attr("id"))
    assert_equal(nil, textarea.attr("name"))
  end

  def test_attributes
    name = "some_name"
    value = "some_value"
    id = "some_id"

    field = Reform::Field::TextArea.new({
      :name => name,
      :value => value,
      :id => id,
    })
    doc = Nokogiri.parse(field.to_s)

    # There is one and only one textarea tag
    assert_equal(1, doc.css("textarea").size)
    textarea = doc.css("textarea").first

    # All the attributes are set correctly
    assert_equal(id, textarea.attr("id"))
    assert_equal(name, textarea.attr("name"))
    assert_equal(value, textarea.text())
  end
end

