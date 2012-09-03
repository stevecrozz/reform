class SelectOptionTest < Test::Unit::TestCase
  def test_simple_options_create
    option1 = [ "Some Value", "some_value" ]
    option2 = [ "Another Value", "another_value" ]

    options = Reform::SelectOptions.new([
      option1, option2
    ])

    # Must inject a root node to validate, otherwise it is invalid XML
    doc = Nokogiri.parse("<root>%s</root>" % options.to_s)
    options = doc.css("root > option")

    # There are two top-level options
    assert_equal(2, options.size)

    # Both options have correct value and text
    assert_equal(option1[0], options[0].text())
    assert_equal(option1[1], options[0].attr("value"))
    assert_equal(option2[0], options[1].text())
    assert_equal(option2[1], options[1].attr("value"))
  end

  def test_selected_options_create
    option1 = [ "Some Value", "some_value" ]
    option2 = [ "Another Value", "another_value" ]
    option3 = [ "Third Value", "third_value" ]

    options = Reform::SelectOptions.new(
      [ option1, option2, option3 ],
      [ "some_value", "third_value" ]
    )

    # Must inject a root node to validate, otherwise it is invalid XML
    doc = Nokogiri.parse("<root>%s</root>" % options.to_s)
    options = doc.css("root > option")

    # The correct options are selected
    assert_equal("selected", options[0].attr("selected"))
    assert_equal("selected", options[2].attr("selected"))
  end

  def test_one_level_nested_options_create
    option1 = [ "Some Value", "some_value" ]
    option2 = [ "Another Value", "another_value" ]
    option3 = [ "Group 1", [ option1, option2 ] ]
    option4 = [ "Third Value", "third_value" ]

    options = Reform::SelectOptions.new([
      option3, option4
    ])

    # Must inject a root node to validate, otherwise it is invalid XML
    doc = Nokogiri.parse("<root>%s</root>" % options.to_s)
    top_level_options = doc.css("root > option")
    top_level_optgroups = doc.css("root > optgroup")

    # There is one and only one top-level option
    assert_equal(1, top_level_options.size)
    assert_equal(option4[0], top_level_options[0].text())
    assert_equal(option4[1], top_level_options[0].attr("value"))

    # There is one and only one top-level optgroup
    assert_equal(1, top_level_optgroups.size)

    nested_options = top_level_optgroups.css("optgroup > option")

    # There are exactly two nested options, and they both have correct
    # values and text
    assert_equal(2, nested_options.size)
    assert_equal(option1[0], nested_options[0].text())
    assert_equal(option1[1], nested_options[0].attr("value"))
    assert_equal(option2[0], nested_options[1].text())
    assert_equal(option2[1], nested_options[1].attr("value"))
  end
end

