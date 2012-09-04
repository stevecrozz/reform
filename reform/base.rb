module Reform

  # Reform::Base is an abstract class from which all form classes should
  # descend.
  class Base

    # Array of field instances
    attr_accessor :fields

    # Any first-order descendent of Reform::Base should receive some default
    # instance variables
    #
    # @param [Reform::Base] descendent class
    def self.inherited(klass)
      if klass.superclass.name =~ /^Reform::/
        klass.instance_eval do
          @__meta = {
            :fields => [],
            :fieldsets => [],
            :field_names => [],
            :field_lookup => {},
            :action => "",
            :method => "post",
            :values => {},
          }
        end
      end
    end

    # Declare a field within a form class
    #
    # @param [#to_s] name of the field
    # @param [Reform::Field::Base] field class to use
    # @param [Hash] options optional parameters to use for instantiating the
    #   field class
    def self.field(name, klass, options={})
      options[:name] ||= name.to_s
      options[:id] ||= "%s_%s" % [self.name, name]
      @__meta[:fields].push([klass, options])
    end

    # Accessor for examining the field class' fields
    #
    # @return [Array] list of fields
    def self.fields
      @__meta[:fields]
    end

    # Instantiate the form class
    #
    # @param [Hash] opts
    # @option opts [String] :action form action
    # @option opts [String] :method form method
    # @option opts [Hash] :values values to set on the form's elements
    def initialize(opts={})
      @__meta = self.meta

      @action = opts[:action] || @__meta[:action]
      @method = opts[:method] || @__meta[:method]
      @values = opts[:values] || @__meta[:values]

      @fields = []

      # Instantiate each field specified by the class definition
      @__meta[:fields].each do |f|
        field_class, field_options = f

        if field_options[:name]
          field_options[:value] = @values[field_options[:name].to_sym]
        end

        # Instantiate the field
        field = field_class.new(field_options)
        @fields.push(field)
      end
    end

    # Is the form valid?
    def valid?
      true
    end

    # Get the original parameters that were used to create the form's class
    #
    # @return [Hash]
    def meta
      self.class.instance_variable_get(:@__meta)
    end
    protected :meta

    # Render the form
    #
    # @return [String] HTML representation of the form
    def to_s
      ret  = "<form method=\"%s\" action=\"%s\">" % [ @method, @action ]

      ret += "<ol>"
      self.fields.each do |field|
        ret += "<li>" + field.label + field.to_s + "</li>"
      end
      ret += "</ol>"

      ret += "</form>"
      return ret
    end
  end
end
