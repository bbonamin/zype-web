# frozen_string_literal: true
class AddSubscriptionRequiredToVideo < ActiveRecord::Migration[5.0]
  def up
    add_column :videos, :subscription_required, :boolean, default: false, null: false
    set_subscription_required_values
  end

  def down
    remove_column :videos, :subscription_required
  end

  private

  def set_subscription_required_values
    Video.find_each do |video|
      video.update_attribute(:subscription_required, video.raw_payload.fetch('subscription_required'))
    end
  end
end
