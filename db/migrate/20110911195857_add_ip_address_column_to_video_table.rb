class AddIpAddressColumnToVideoTable < ActiveRecord::Migration
  def self.up
    add_column :videos, :remote_ip, :string
  end

  def self.down
    remove_column :videos, :remote_ip
  end
end
