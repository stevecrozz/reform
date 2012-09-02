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
      if klass.superclass == Reform::Base
        klass.instance_eval do
          @__meta = {
            :fields => [],
            :fieldsets => [],
            :field_names => [],
            :field_lookup => {},
            :action => "",
            :method => "post",
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

    def initialize(options={})
      @__meta = {}

      if options.has_key?(:action)
        @__meta[:action] = options[:action]
      end

      if options.has_key?(:method)
        @__meta[:method] = options[:method]
      end

      @fields = []

      meta[:fields].each do |f|
        @fields.push(f[0].new(f[1]))
      end
    end

    def valid?
      true
    end

    def meta
      self.class.instance_variable_get(:@__meta)
    end

    def to_s
      ret  = "<form method=\"%s\" action=\"%s\">" % [
        @__meta[:method], @__meta[:action]
      ]

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
