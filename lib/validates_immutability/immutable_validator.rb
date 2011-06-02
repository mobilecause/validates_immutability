module ValidatesImmutability
  class ImmutableValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if options.key?(:on)
        raise ArgumentError, "Unknown option :on"
      end
      return if record.new_record?
      if record.send("#{attribute}_changed?")
        record.errors.add(attribute, (options[:message] || "can't be modified"))
      end
    end
  end
end

# ImmutableValidator needs to be in global scope to be recognized up by AR
class ImmutableValidator < ValidatesImmutability::ImmutableValidator
end