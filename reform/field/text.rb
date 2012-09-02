module Reform
  module Field
    class Text < Base
      def to_s
        attributes = [ "type=\"text\"" ]
        attributes.push("id=\"%s\"" % @id) if @id
        attributes.push("name=\"%s\"" % @name) if @name
        attributes.push("value=\"%s\"" % @value) if @value

        "<input %s></input>" % attributes.join(" ")
      end
    end
  end
end
