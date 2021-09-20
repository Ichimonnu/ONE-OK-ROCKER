class ApplicationController < ActionController::Base
    protect_from_forgery prepend: true
    before_action :configure_permitted_parameters, if: :devise_controller?
    # i18
    around_action :switch_locale
    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end
    # Get locale from top-level domain or return +nil+ if such locale is not available
    # You have to put something like:
    #   127.0.0.1 application.com
    #   127.0.0.1 application.it
    #   127.0.0.1 application.pl
    # in your /etc/hosts file to try this out locally
    def extract_locale_from_tld
      parsed_locale = request.host.split('.').last
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end
    def default_url_options
      { locale: I18n.locale }
    end
    # i18
    protected
    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # アカウント編集の時にnameとprofileのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image])
    end
end