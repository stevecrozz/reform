module Reform

  # A class representation of select options representable as groups of
  # <option> tags
  class SelectOptions

    attr_accessor :options

    # Initialize the SelectOption instance
    #
    # @param [Array] options nestable two-tuples of options ([name, value])
    def initialize(options=[])
      @options = options
    end

    # Represent this instance as HTML
    #
    # @return [String] HTML representation of the options
    def to_s
      self.class.to_s(@options)
    end

    # Represent an options array as HTML
    #
    # @param [Array] options nestable two-tuples of options ([name, value])
    # @return [String] HTML representation of the options
    def self.to_s(options)
      options.map { |name, value|
        case value
        when String, Symbol:
          "<option value=\"%s\">%s</option>" % [value, name]
        else
          "<optgroup label=\"%s\">%s</optgroup>" % [name, self.to_s(value)]
        end
      }.join("")
    end
  end
end
