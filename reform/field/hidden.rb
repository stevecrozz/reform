module Reform
  module Field
    class Hidden < Base
      def to_s
        attributes = ["type=\"hidden\""]
        attributes.push("id=\"%s\"" % @id) if @id
        attributes.push("name=\"%s\"" % @name) if @name
        attributes.push("value=\"%s\"" % @value) if @value

        "<input %s></input>" % attributes.join(" ")
      end

      def hidden?
        true
      end
    end
  end
end
