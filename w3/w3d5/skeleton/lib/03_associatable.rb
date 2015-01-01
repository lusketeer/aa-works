require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name || @class_name.pluralize.downcase.to_s
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key  = options[:foreign_key] || "#{name}_id".to_sym
    @class_name   = options[:class_name]  || name.to_s.capitalize
    @primary_key  = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key  = options[:foreign_key] || "#{self_class_name.underscore}_id".to_sym
    @class_name   = options[:class_name]  || name.to_s.capitalize.singularize
    @primary_key  = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    assoc_options[name] = BelongsToOptions.new(name, options)
    result_options = assoc_options[name]
    define_method(name) do
      foreign_key = result_options.foreign_key
      result_options.model_class.where(
        result_options.primary_key => self.send(foreign_key)
      ).first
    end
  end

  def has_many(name, options = {})
    result_options = HasManyOptions.new(name, self.to_s, options)
    define_method(name) do
      primary_key = result_options.send(:primary_key)
      result_options.model_class.where(
        result_options.send(:foreign_key) => self.send(primary_key)
      )
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
