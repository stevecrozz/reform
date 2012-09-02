module Reform
  module Field
    class Select < Base
      attr_accessor :options

      def initialize(options={})
        if options[:options]
          @options = SelectOptions.new(options[:options])
        end

        super(options)
      end

      def to_s
        attributes = []
        attributes.push("id=\"%s\"" % @id) if @id
        attributes.push("name=\"%s\"" % @name) if @name

        "<select %s>%s</select>" % [attributes.join(" "), @options]
      end
    end
  end
end
