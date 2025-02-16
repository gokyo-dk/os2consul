# frozen_string_literal: true

require_dependency Rails.root.join('app', 'controllers', 'account_controller').to_s

class AccountController < ApplicationController
  private

  def account_params
    # Don't allow users to change their username
    attributes = if @account.organization?
                   [:phone_number, :email_on_comment, :email_on_comment_reply, :newsletter,
                    organization_attributes: %i[name responsible_name]]
                 else
                   %i[public_activity public_interests email_on_comment
                      email_on_comment_reply email_on_direct_message email_digest newsletter
                      official_position_badge recommended_debates recommended_proposals]
                 end
    params.require(:account).permit(*attributes)
  end
end
