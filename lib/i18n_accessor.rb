require "i18n_accessor/version"
require 'active_support/core_ext/string/inflections'

module I18nAccessor
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def i18n_accessor(accessor_name, options={})
      scope = options.fetch(:scope) { nil }
      key = options.fetch(:key) { nil }

      class_name = self.name.underscore
      is_active_hash = defined?(ActiveHash::Base) && self.ancestors.include?(ActiveHash::Base)

      define_method accessor_name do
        unless key
          key = if is_active_hash
            self.identifier
          else
            accessor_name
          end
        end

        i18n_path = [
          class_name,
          key,
          scope
        ].compact.join('.')

        I18n.t("#{i18n_path}")
      end
    end
  end
end
