module Reform
  module Field
    class Base
      attr_accessor :id
      attr_accessor :name
      attr_accessor :value

      def initialize(options={})
        @id = options[:id]
        @name = options[:label] || options[:name]
        @value = options[:value]
      end

      def label
        "<label for=\"%s\">%s</label>" % [@id, @name]
      end

      def hidden?
        false
      end
    end
  end
end

