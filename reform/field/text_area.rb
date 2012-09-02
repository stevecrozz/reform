module Reform
  module Field
    class TextArea < Base
      def to_s
        attributes = []
        attributes.push("id=\"%s\"" % @id) if @id
        attributes.push("name=\"%s\"" % @name) if @name

        "<textarea %s>%s</textarea>" % [attributes.join(" "), @value]
      end
    end
  end
end
