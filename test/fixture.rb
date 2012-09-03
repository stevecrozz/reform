class EmptyForm < Reform::Base
end

class SimpleForm < Reform::Base
  field "name", Reform::Field::Text
end

class RegularForm < Reform::Base
  field "text_field", Reform::Field::Text
  field "select_field", Reform::Field::Select
end

