# Reform
Reform is a class-based form library. Each form you create is defined
first as a class using a declarative syntax. To use one, you simply
instantiate its class and make use of its handy instance-methods.

## Examples
```ruby
class MySimpleForm < Reform::Base
  field "name", Reform::Field::Text
end

# instantiate
form = MySimpleForm.new(:action => "/some/path")

# render
irb> form.to_s
=> "<form method=\"post\" action=\"/some/path\"><ol><li><label for=\"SimpleForm_name\">name</label><input type=\"text\" id=\"SimpleForm_name\" name=\"name\"></input></li></ol></form>"
```
