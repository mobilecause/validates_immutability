require "active_support"

module ValidatesImmutability
  extend ActiveSupport::Concern
  
  module ClassMethods
    def immutable(options = {})
      if options.key?(:on)
        raise ArgumentError, "Unknown option :on"
      end
      options.merge!(:on => :update)
      error_msg = options.delete(:message) || "Updates are not allowed."
      validate options do
        errors[:base] << error_msg if changed?
      end
    end
  end
end

require "validates_immutability/version"

ActiveSupport.on_load :active_record do
  ActiveRecord::Base.send(:include, ValidatesImmutability)
  require "validates_immutability/immutable_validator"
end