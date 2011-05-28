require "active_model"

module ValidatesImmutability
  class ImmutableValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if record.new_record?
      if record.send("#{attribute}_changed?")
        record.errors.add(attribute, "can't be modified")
      end
    end
  end
end

require "validates_immutability/version"