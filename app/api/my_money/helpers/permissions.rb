module MyMoney
  module Helpers
    module Permissions
      extend Grape::API::Helpers

      def check_category!(id, class_name = nil)
        category = current_user.categories.find_by(id: id)
        error!("Category was not found", 404) if category.nil?
        error!('Unauthorized or invalid category.', 401) if class_name.present? && category.record_type != class_name
      end
    end
  end
end