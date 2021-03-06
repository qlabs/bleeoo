# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110911203307) do

  create_table "blacklists", :force => true do |t|
    t.string   "remote_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "uid"
    t.string   "framey_name"
    t.string   "framey_video_url"
    t.string   "framey_thumbnail_url", :default => "http://framey.com/images/thumb_placeholder.png"
    t.integer  "views",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "short_link"
    t.boolean  "published",            :default => false
    t.string   "remote_ip"
  end

end
