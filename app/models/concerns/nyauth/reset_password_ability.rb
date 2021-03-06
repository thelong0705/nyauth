module Nyauth
  module ResetPasswordAbility
    extend ActiveSupport::Concern

    included do
      before_validation :check_reset_password_key, on: %i(reset_password edit_reset_password)
      validates :password, presence: true,
                           length: { minimum: Nyauth.configuration.password_minium },
                           on: [:create, :update_password, :reset_password]
      validates :password, confirmation: true
    end

    def reset_password(params)
      self.attributes = params
      self.save(context: :reset_password)
    end

    def request_reset_password
      self.reset_password_key = SecureRandom.hex(32)
      self.reset_password_key_expired_at = Time.current + Nyauth.configuration.reset_password_expire_limit
      save
    end

    private

    def check_reset_password_key
      if reset_password_key_expired_at.past?
        errors.add(:reset_password_key, :key_expired)
      else
        self.reset_password_key = nil
      end
    end
  end
end
