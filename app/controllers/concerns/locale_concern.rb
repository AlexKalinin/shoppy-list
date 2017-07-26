module LocaleConcern
  extend ActiveSupport::Concern
  included do
    before_action :set_locale
  end

  private
    def set_locale
      I18n.locale = :ru
    end
end