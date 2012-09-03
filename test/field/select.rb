class FieldSelectTest < Test::Unit::TestCase
  def test_empty_select_field
    field = Reform::Field::Select.new
    doc = Nokogiri.parse(field.to_s)

    # There is one and only one select tag
    assert_equal(1, doc.css("select").size)

    # id and name attributes are not set
    select = doc.css("select").first
    assert_equal(nil, select.attr("id"))
    assert_equal(nil, select.attr("name"))
  end

  def test_select_field_attributes
    field = Reform::Field::Select.new({
      :id => "myid",
      :name => "myname",
    })
    doc = Nokogiri.parse(field.to_s)

    # There is one and only one select tag
    assert_equal(1, doc.css("select").size)
    select = doc.css("select").first

    # The select tag's attributes are correct
    assert_equal("myid", select.attr("id"))
    assert_equal("myname", select.attr("name"))
  end

  def test_creates_select_options
    options = [ ["Some Value", "some_value"] ]
    field = Reform::Field::Select.new(
      :options => options
    )

    raw_opts_doc = Nokogiri.parse(
      Reform::SelectOptions.new(options).to_s
    ).css("option")
    select_opts_doc = Nokogiri.parse(field.to_s).css("select > option")

    assert_equal(raw_opts_doc.to_s, select_opts_doc.to_s)
  end
end
