# # forms namespace for all forms
module Forms
  # Creates an Object that we can use in the wizard as a form object and return validation errors
  class UserForm
    include ActiveModel::Model

    attr_accessor :user_id, :username, :first_name, :last_name, :status, :role, :visible, :profile
    validates :user_id, :username, :first_name, :last_name, :status, :role, :visible, presence: true

    # set all the attr accessors on init
    def initialize(user_params)
      @user_params = user_params
      user_params.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    # save the user to the user user
  #   def save
  #     begin
  #       return false if invalid?
  #       ActiveRecord::Base.transaction do
  #         user = User.new(@user_params.except(:user_id))
  #         if user.valid? && user.save!
  #           user = User.find(user_id)
  #           user.update!(profile: user)
  #         else
  #           return false
  #         end
  #       end
  #       true
  #     rescue ActiveRecord::StatementInvalid => e
  #       errors.add(:base, e.message)
  #       false
  #     end
  #   end

    def save
      user = User.new(@user_params)
      user.save
    end
  end
end
