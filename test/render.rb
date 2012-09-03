class RenderTest < Test::Unit::TestCase
  def test_empty_form
    form = EmptyForm.new
    doc = Nokogiri.parse(form.to_s)
    assert_equal(1, doc.css("form").size)
    assert_equal(0, doc.css("input, textarea, select").size)
  end

  def test_action
    action = "/some/place"
    form = EmptyForm.new(:action => action)
    doc = Nokogiri.parse(form.to_s)
    assert_equal(action, doc.css("form").first.attribute("action").to_s)
  end

  def test_method
    method = "DELETE"
    form = EmptyForm.new(:method => method)
    doc = Nokogiri.parse(form.to_s)
    assert_equal(method, doc.css("form").first.attribute("method").to_s)
  end

  def test_simple_form
    form = SimpleForm.new
    doc = Nokogiri.parse(form.to_s)
    input = doc.css("input")
    assert_equal("SimpleForm_name", input.attribute("id").to_s)
    assert_equal("name", input.attribute("name").to_s)
  end
end
