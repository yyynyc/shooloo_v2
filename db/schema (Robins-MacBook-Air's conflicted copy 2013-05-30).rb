# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130528151325) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "recipient_id"
    t.boolean  "read"
  end

  add_index "activities", ["trackable_id"], :name => "index_activities_on_trackable_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "alarms", :force => true do |t|
    t.integer  "alarmed_post_id"
    t.integer  "alarmed_comment_id"
    t.integer  "alarmer_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "alarms", ["alarmed_comment_id"], :name => "index_alarms_on_alarmed_comment_id"
  add_index "alarms", ["alarmed_post_id"], :name => "index_alarms_on_alarmed_post_id"
  add_index "alarms", ["alarmer_id"], :name => "index_alarms_on_alarmer_id"

  create_table "authorizations", :force => true do |t|
    t.integer  "authorized_id"
    t.integer  "authorizer_id"
    t.string   "approval",      :default => "pending"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "authorizations", ["authorized_id"], :name => "index_authorizations_on_authorized_id"
  add_index "authorizations", ["authorizer_id"], :name => "index_authorizations_on_authorizer_id"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "commenter_id"
    t.integer  "commented_post_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "visible",            :default => true
    t.integer  "likes_count"
  end

  add_index "comments", ["commenter_id", "created_at"], :name => "index_comments_on_commenter_id_and_created_at"

  create_table "flags", :force => true do |t|
    t.text     "name"
    t.integer  "rating_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "improvements", :force => true do |t|
    t.text     "name"
    t.integer  "rating_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "likes", :force => true do |t|
    t.integer  "liked_post_id"
    t.integer  "liked_comment_id"
    t.integer  "liker_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "likes", ["liked_comment_id"], :name => "index_likes_on_liked_comment_id"
  add_index "likes", ["liked_post_id"], :name => "index_likes_on_liked_post_id"
  add_index "likes", ["liker_id"], :name => "index_likes_on_liker_id"

  create_table "nudges", :force => true do |t|
    t.integer  "nudger_id"
    t.integer  "nudged_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "operations", :force => true do |t|
    t.text     "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "rating_id"
    t.integer  "position"
  end

  create_table "posts", :force => true do |t|
    t.text     "question"
    t.string   "answer"
    t.string   "grade"
    t.integer  "user_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "category"
    t.string   "image_host"
    t.integer  "answer_correctness_1_count"
    t.integer  "answer_correctness_2_count"
    t.integer  "answer_correctness_3_count"
    t.integer  "answer_correctness_4_count"
    t.integer  "operation_whole_count"
    t.boolean  "visible",                        :default => true
    t.integer  "ratings_count"
    t.integer  "overall_true_count"
    t.integer  "overall_false_count"
    t.integer  "grade_below_count"
    t.integer  "grade_right_count"
    t.integer  "grade_above_count"
    t.integer  "steps_1_count"
    t.integer  "steps_2_count"
    t.integer  "steps_3_count"
    t.integer  "steps_4_count"
    t.integer  "steps_5_count"
    t.integer  "steps_6_count"
    t.integer  "operation_decimal_count"
    t.integer  "operation_fraction_count"
    t.integer  "operation_percentage_count"
    t.integer  "operation_negative_count"
    t.integer  "operation_addition_count"
    t.integer  "operation_substraction_count"
    t.integer  "operation_multiplication_count"
    t.integer  "operation_division_count"
    t.integer  "vocabulary_count"
    t.integer  "grammar_count"
    t.integer  "structure_count"
    t.integer  "clarity_count"
    t.integer  "originality_count"
    t.integer  "plagerism_count"
    t.integer  "content_count"
    t.integer  "image_count"
    t.integer  "comments_count"
    t.integer  "likes_count"
  end

  add_index "posts", ["user_id", "created_at"], :name => "index_posts_on_user_id_and_created_at"

  create_table "ratings", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rated_post_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "answer_correctness"
    t.integer  "steps"
    t.integer  "grade_suitability"
    t.boolean  "overall_rating"
  end

  add_index "ratings", ["rated_post_id"], :name => "index_ratings_on_rated_post_id"
  add_index "ratings", ["rater_id"], :name => "index_ratings_on_rater_id"

  create_table "ref_checks", :force => true do |t|
    t.integer  "referral_id"
    t.boolean  "name_true"
    t.boolean  "role_true"
    t.boolean  "screen_name_appropriate"
    t.boolean  "avatar_appropriate"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "referrals", :force => true do |t|
    t.integer  "referred_id"
    t.integer  "referrer_id"
    t.string   "approval",                :default => "pending"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.boolean  "name_true"
    t.boolean  "role_true"
    t.boolean  "screen_name_appropriate"
    t.boolean  "avatar_appropriate"
  end

  add_index "referrals", ["referred_id"], :name => "index_referrals_on_referred_id"
  add_index "referrals", ["referrer_id"], :name => "index_referrals_on_referrer_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "email"
    t.string   "email_confirmation"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "screen_name"
    t.integer  "grade"
    t.string   "last_name"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "privacy"
    t.boolean  "rules"
    t.integer  "posts_count"
    t.integer  "rated_posts_count"
    t.integer  "commented_posts_count"
    t.integer  "followers_count"
    t.integer  "followed_users_count"
    t.integer  "auth_req_count",         :default => 0
    t.string   "auth_status"
    t.string   "role",                   :default => "student"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["screen_name"], :name => "index_users_on_screen_name", :unique => true

end
