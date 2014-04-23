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

ActiveRecord::Schema.define(:version => 20140422143507) do

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

  create_table "assignments", :force => true do |t|
    t.integer  "assigner_id"
    t.integer  "level_id"
    t.integer  "domain_id"
    t.integer  "standard_id"
    t.integer  "assigned_post_id"
    t.text     "instruction"
    t.integer  "assignee_level"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "authorizations", :force => true do |t|
    t.integer  "authorized_id"
    t.integer  "authorizer_id"
    t.string   "approval",      :default => "pending"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "code"
  end

  add_index "authorizations", ["authorized_id"], :name => "index_authorizations_on_authorized_id"
  add_index "authorizations", ["authorizer_id", "authorized_id"], :name => "index_authorizations_on_authorizer_id_and_authorized_id", :unique => true
  add_index "authorizations", ["authorizer_id"], :name => "index_authorizations_on_authorizer_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "choices", :force => true do |t|
    t.integer  "user_id"
    t.integer  "gift_id"
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "visible",            :default => true
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "colors", :force => true do |t|
    t.integer  "value"
    t.string   "code"
    t.string   "weakness"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "commenter_id"
    t.integer  "commented_post_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "visible",             :default => true
    t.integer  "likes_count"
    t.boolean  "new_comment"
    t.integer  "commented_lesson_id"
    t.integer  "response_id"
    t.boolean  "graded",              :default => false
  end

  add_index "comments", ["commenter_id", "created_at"], :name => "index_comments_on_commenter_id_and_created_at"

  create_table "corrections", :force => true do |t|
    t.integer  "editor_id"
    t.integer  "corrected_post_id"
    t.integer  "competition"
    t.text     "question"
    t.text     "answer"
    t.integer  "steps"
    t.integer  "level_id"
    t.integer  "domain_id"
    t.integer  "standard_id"
    t.boolean  "grammar"
    t.boolean  "concept_clear"
    t.boolean  "math_correct"
    t.boolean  "answer_complete"
    t.string   "state"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "corrections", ["corrected_post_id"], :name => "index_corrections_on_corrected_post_id"

  create_table "domains", :force => true do |t|
    t.integer  "level_id"
    t.string   "name"
    t.string   "symbol"
    t.string   "core"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "benefactor_id"
    t.integer  "beneficiary_id"
    t.string   "event"
    t.integer  "value"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "flags", :force => true do |t|
    t.text     "name"
    t.integer  "rating_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "gifts", :force => true do |t|
    t.integer  "giver_id"
    t.integer  "receiver_id"
    t.integer  "week"
    t.integer  "year"
    t.integer  "choice_id"
    t.boolean  "sent"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "sent_week"
    t.integer  "sent_year"
  end

  create_table "gradings", :force => true do |t|
    t.integer  "graded_post_id"
    t.integer  "graded_comment_id"
    t.integer  "grader_id"
    t.integer  "level_id"
    t.integer  "domain_id"
    t.integer  "standard_id"
    t.boolean  "concept"
    t.boolean  "precision"
    t.boolean  "computation"
    t.boolean  "grammar"
    t.boolean  "courtesy"
    t.text     "note"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "gradee_id"
  end

  add_index "gradings", ["graded_comment_id"], :name => "index_gradings_on_graded_comment_id"
  add_index "gradings", ["graded_post_id"], :name => "index_gradings_on_graded_post_id"
  add_index "gradings", ["grader_id", "graded_comment_id"], :name => "index_gradings_on_grader_id_and_graded_comment_id", :unique => true
  add_index "gradings", ["grader_id", "graded_post_id"], :name => "index_gradings_on_grader_id_and_graded_post_id", :unique => true
  add_index "gradings", ["grader_id"], :name => "index_gradings_on_grader_id"

  create_table "homeworks", :force => true do |t|
    t.integer  "week"
    t.integer  "year"
    t.integer  "user_id"
    t.integer  "post_count"
    t.integer  "comment_count"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "login_count",   :default => 0
  end

  create_table "improvements", :force => true do |t|
    t.text     "name"
    t.integer  "rating_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "introductions", :force => true do |t|
    t.integer  "introducer_id"
    t.integer  "introducee_id"
    t.string   "introducer_email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "invitation_code"
  end

  create_table "invitemails", :force => true do |t|
    t.string   "to"
    t.string   "subject"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invites", :force => true do |t|
    t.integer  "inviter_id"
    t.integer  "invited_post_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "keeps", :force => true do |t|
    t.integer  "keeper_id"
    t.integer  "kept_post_id"
    t.text     "note"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "keeps", ["keeper_id", "kept_post_id"], :name => "index_keeps_on_keeper_id_and_kept_post_id", :unique => true
  add_index "keeps", ["keeper_id"], :name => "index_keeps_on_keeper_id"
  add_index "keeps", ["kept_post_id"], :name => "index_keeps_on_kept_post_id"

  create_table "lessons", :force => true do |t|
    t.integer  "post_a_id"
    t.integer  "post_b_id"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "level_id"
    t.integer  "domain_id"
    t.integer  "standard_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "practice_id"
    t.integer  "likes_count"
    t.integer  "comments_count"
  end

  create_table "levels", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "liked_post_id"
    t.integer  "liked_comment_id"
    t.integer  "liker_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "liked_lesson_id"
  end

  add_index "likes", ["liked_comment_id"], :name => "index_likes_on_liked_comment_id"
  add_index "likes", ["liked_post_id"], :name => "index_likes_on_liked_post_id"
  add_index "likes", ["liker_id"], :name => "index_likes_on_liker_id"

  create_table "marks", :force => true do |t|
    t.integer  "mark",       :default => 0
    t.string   "bonus"
    t.string   "penalty"
    t.integer  "grading_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "natures", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "complete"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "points", :force => true do |t|
    t.integer  "user_id"
    t.integer  "advocacy",    :default => 0
    t.integer  "inspiration", :default => 0
    t.integer  "education",   :default => 0
    t.integer  "competition", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "posts", :force => true do |t|
    t.text     "question"
    t.text     "answer"
    t.string   "grade"
    t.integer  "user_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
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
    t.boolean  "visible",                    :default => true
    t.integer  "ratings_count",              :default => 0
    t.integer  "overall_true_count",         :default => 0
    t.integer  "overall_false_count"
    t.integer  "ccss_right_count"
    t.integer  "steps_1_count"
    t.integer  "steps_2_count"
    t.integer  "steps_3_count"
    t.integer  "steps_4_count"
    t.integer  "steps_5_count"
    t.integer  "steps_6_count"
    t.integer  "vocabulary_count"
    t.integer  "grammar_count"
    t.integer  "structure_count"
    t.integer  "clarity_count"
    t.integer  "originality_count"
    t.integer  "comments_count",             :default => 0
    t.integer  "likes_count",                :default => 0
    t.integer  "level_id"
    t.integer  "domain_id"
    t.integer  "standard_id"
    t.integer  "ccss_wrong_grade_count"
    t.integer  "ccss_wrong_skill_count"
    t.integer  "ccss_wrong_ican_count"
    t.integer  "quality_id"
    t.integer  "subject_id"
    t.integer  "response_id"
    t.boolean  "graded",                     :default => false
    t.string   "state"
    t.integer  "competition"
    t.string   "qualified"
    t.integer  "steps"
  end

  add_index "posts", ["state"], :name => "index_posts_on_state"
  add_index "posts", ["user_id", "created_at"], :name => "index_posts_on_user_id_and_created_at"

  create_table "practices", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "symbol"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "qualities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rated_post_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "answer_correctness"
    t.integer  "steps"
    t.integer  "ccss_suitability"
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
    t.string   "approval",    :default => "pending", :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
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

  create_table "reminders", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "reminded_response_id"
    t.integer  "remindee_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "responses", :force => true do |t|
    t.integer  "assignee_id"
    t.integer  "grading_average", :default => 0
    t.integer  "assignment_id"
    t.boolean  "completed",       :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "graded"
    t.integer  "reminders_count", :default => 0
  end

  add_index "responses", ["assignment_id", "assignee_id"], :name => "index_responses_on_assignment_id_and_assignee_id", :unique => true

  create_table "scorecards", :force => true do |t|
    t.integer  "response_id"
    t.integer  "color_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "post_id"
    t.integer  "comment_id"
  end

  add_index "scorecards", ["response_id"], :name => "index_scorecards_on_response_id"

  create_table "scores", :force => true do |t|
    t.integer  "year"
    t.integer  "week"
    t.integer  "benefactor_id"
    t.integer  "beneficiary_id"
    t.integer  "weekly_tally"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "standards", :force => true do |t|
    t.integer  "domain_id"
    t.integer  "level_id"
    t.text     "symbol"
    t.text     "short"
    t.text     "url"
    t.text     "description"
    t.text     "ICan"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "parent_email"
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
    t.integer  "post_count",             :default => 0
    t.integer  "rating_count",           :default => 0
    t.integer  "comment_count",          :default => 0
    t.integer  "follower_count",         :default => 0
    t.integer  "following_count",        :default => 0
    t.string   "role",                   :default => "student"
    t.boolean  "visible",                :default => false
    t.string   "personal_email"
    t.string   "school_name"
    t.string   "school_url"
    t.string   "social_media_url"
    t.string   "email_sent_to"
    t.integer  "gift_received_count",    :default => 0
    t.integer  "gift_sent_count",        :default => 0
    t.string   "address_city"
    t.string   "address_state"
  end

  add_index "users", ["personal_email"], :name => "index_users_on_personal_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["screen_name"], :name => "index_users_on_screen_name", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.string   "player_loc"
    t.string   "duration"
    t.string   "length"
    t.string   "tags"
    t.integer  "category_id"
    t.integer  "practice_id"
    t.integer  "standard_id"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.boolean  "student",                 :default => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "slug"
    t.string   "video_mp4_file_name"
    t.string   "video_mp4_content_type"
    t.integer  "video_mp4_file_size"
    t.datetime "video_mp4_updated_at"
    t.string   "video_ogv_file_name"
    t.string   "video_ogv_content_type"
    t.integer  "video_ogv_file_size"
    t.datetime "video_ogv_updated_at"
    t.string   "video_webm_file_name"
    t.string   "video_webm_content_type"
    t.integer  "video_webm_file_size"
    t.datetime "video_webm_updated_at"
    t.boolean  "visible",                 :default => true
    t.integer  "position",                :default => 0
  end

  add_index "videos", ["slug"], :name => "index_videos_on_slug"

end
