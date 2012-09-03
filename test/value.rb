class ValueTest < Test::Unit::TestCase
  def test_value_form
    values = { :name => "what a silly value" }
    form = SimpleForm.new(:values => values)
    doc = Nokogiri.parse(form.to_s)

    input = doc.css("input")[0]
    assert_equal(values[:name], input.attr("value"))
  end
end
