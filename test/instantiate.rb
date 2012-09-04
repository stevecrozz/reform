class ValueTest < Test::Unit::TestCase

  class MockFieldForm < Reform::Base
  end

  def test_value_form
    values = { :name => "what a silly value" }
    form = SimpleForm.new(:values => values)
    doc = Nokogiri.parse(form.to_s)

    input = doc.css("input")[0]
    assert_equal(values[:name], input.attr("value"))
  end

  def test_passes_all_options_to_field
    # This test ensures that any options specified are actually used to
    # instantiate the field when the form itself is instantiated. Specific
    # options and how they affect the way fields behave are tested under the
    # field's tests.
    mock_field = mock()
    mock_options = {
      :option1 => 'anoption',
      :option2 => 'anotheroption',
    }

    MockFieldForm.field("one", mock_field, mock_options)

    # The "field" is instantiated with all the options
    mock_field.expects(:new).with(mock_options).returns("it worked")
    form = MockFieldForm.new

    # The instantiated "field" is in the form instance's fields
    assert_equal(["it worked"], form.fields)
  end
end
