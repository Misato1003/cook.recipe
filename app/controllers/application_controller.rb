class ApplicationController < ActionController::Base
    
    #devise(ユーザー名、プロフィール画像、一言紹介が登録できないため)
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    
     protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :image, :introduction])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :image, :introduction])
    end
end
