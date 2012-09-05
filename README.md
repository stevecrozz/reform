# Reform
Reform is a class-based form library. Each form you create is defined
first as a class using a declarative syntax. To use one, you simply
instantiate its class and make use of its handy instance-methods.

## Basic Example
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

## ActiveRecord Integration
```ruby
class User < ActiveRecord::Base
  belongs_to :group
end

class UserForm < Reform::Model::ActiveRecord
  model User
end

form = UserForm.new
form.to_s
```
...
```html
<form method="post" action="">
  <ol>
    <li>
      <label for="UserForm_name">name</label>
      <input type="text" id="UserForm_name" name="name"/>
    </li>
    <li>
      <label for="UserForm_group_id">group_id</label>
      <select id="UserForm_group_id" name="group_id">
        <option value="1">admin</option>
        <option value="2">publisher</option>
        <option value="3">user</option>
      </select>
    </li>
  </ol>
</form>
```

## Rendering
Reform forms can be rendered however you like using Renderer classes.
Simply declare a class that extends Reform::Renderer::Base, implement
the defined interface and your forms will use your rules to render.
Check out the existing renderer classes under reform/renderer/ to get
started. Tell your form to implement the renderer like this:

```ruby
class MyForm < Reform::Base
  renderer MyApp::FormRenderer
end
```
