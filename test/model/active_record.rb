require 'test/model/active_record_fixture'

class ActiveRecordTest < Test::Unit::TestCase

  class UserForm < Reform::Model::ActiveRecord
  end

  class UserFormExclusion < Reform::Model::ActiveRecord
  end

  def test_model_form
    UserForm.model(User)
    assert_equal(Reform::Field::Text, UserForm.fields[0][0])
    assert_equal("name", UserForm.fields[0][1][:name])
    assert_equal(Reform::Field::Select, UserForm.fields[1][0])
    assert_equal("group_id", UserForm.fields[1][1][:name])
  end

  def test_model_form_exclusion
    UserFormExclusion.model(User)
    UserFormExclusion.exclude(:group_id)

    assert_equal(Reform::Field::Text, UserFormExclusion.fields[0][0])
    assert_equal("name", UserFormExclusion.fields[0][1][:name])
    assert_equal(1, UserFormExclusion.fields.size)
  end

  def teardown
    if File.exists?(ACTIVE_RECORD_DB)
      File.unlink(ACTIVE_RECORD_DB)
    end
  end

end
