module Reform
  module Model
    class ActiveRecord < Reform::Base

      def self.associations(model)
        associations = {}
        @model.reflect_on_all_associations.each do |a|
          case a.macro
          when :belongs_to
            associations[a.association_foreign_key] = a
          end
        end

        return associations
      end

      def self.model(klass, options={})
        # Do not include anything that is specifically excluded
        if self.exclude.include?(options[:name])
          return
        end

        # If we're using includes, restrict to the includes
        if self.include.size > 0 && !self.include.include?(option[:name])
          return
        end

        @model = klass
        @associations = associations(@model)

        @model.columns_hash.each do |k,v|
          next if v.primary

          if @associations.has_key?(k)
            field k, Reform::Field::Select, :finder => @associations[k].klass
            next
          end

          case v.type
          when :string
            field k, Reform::Field::Text
          end
        end
      end

      def self.include(fields=[])
        fields = Array(fields)
        @__meta[:fields].reject! do |klass, options|
          !fields.include?(options[:name].to_sym)
        end

        @includes ||= []
        @includes += fields
        return @includes
      end

      def self.exclude(fields=[])
        fields = Array(fields)
        @__meta[:fields].reject! do |klass, options|
          fields.include?(options[:name].to_sym)
        end

        @excludes ||= []
        @excludes += fields
        return @excludes
      end

      # Instantiate the form class, transforming all the select elements with
      # finders into static options
      def initialize(opts={})
        opts[:meta] = self.meta
        opts[:meta][:fields] = self.meta[:fields].map do |klass, options|
          if klass == Reform::Field::Select && options[:finder]
            options[:options] = options[:finder].all.map { |o|
              [o.to_s, o.id.to_s]
            }
          end

          [klass, options]
        end

        super(opts)
      end

      # Is the form valid?
      def valid?
        true
      end

    end
  end
end
