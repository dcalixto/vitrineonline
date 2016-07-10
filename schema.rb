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

ActiveRecord::Schema.define(:version => 20160615123608) do

  create_table "announcements", :force => true do |t|
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "vitrine_id"
  end

  add_index "announcements", ["vitrine_id"], :name => "index_announcements_on_vitrine_id"

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "brands", ["slug"], :name => "index_brands_on_slug"

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "carts", ["user_id"], :name => "index_carts_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "slug"
    t.string   "name"
    t.integer  "gender_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["gender_id"], :name => "index_categories_on_gender_id"
  add_index "categories", ["slug"], :name => "index_categories_on_slug"

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["state_id"], :name => "index_cities_on_state_id"

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "colors_products", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "color_id"
  end

  add_index "colors_products", ["product_id", "color_id"], :name => "index_colors_products_on_product_id_and_color_id"
  add_index "colors_products", ["product_id"], :name => "index_colors_products_on_product_id"

  create_table "colorships", :force => true do |t|
    t.integer  "product_id", :null => false
    t.integer  "color_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "colorships", ["color_id"], :name => "index_colorships_on_color_id"
  add_index "colorships", ["product_id"], :name => "index_colorships_on_product_id"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.boolean  "read",                           :default => false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                           :default => "comments"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "conditions", :force => true do |t|
    t.string   "condition"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contacts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "conversation_participants", :force => true do |t|
    t.boolean  "has_read",        :default => false
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "conversation_participants", ["conversation_id"], :name => "index_conversation_participants_on_conversation_id"
  add_index "conversation_participants", ["user_id"], :name => "index_conversation_participants_on_user_id"

  create_table "conversations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "feedbackable_id"
    t.string   "feedbackable_type"
    t.text     "seller_comment"
    t.text     "buyer_comment"
    t.integer  "user_id"
    t.integer  "vitrine_id"
    t.integer  "product_id"
    t.integer  "buyer_rating"
    t.integer  "seller_rating"
    t.datetime "buyer_feedback_date"
    t.datetime "seller_feedback_date"
    t.integer  "cached_buyer_rating_total"
    t.integer  "cached_seller_rating_total"
    t.float    "cached_weighted_average"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "feedbacks", ["feedbackable_id", "feedbackable_type"], :name => "index_feedbacks_on_feedbackable_id_and_feedbackable_type"
  add_index "feedbacks", ["product_id"], :name => "index_feedbacks_on_product_id"
  add_index "feedbacks", ["user_id"], :name => "index_feedbacks_on_user_id"
  add_index "feedbacks", ["vitrine_id"], :name => "index_feedbacks_on_vitrine_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "genders", :force => true do |t|
    t.string   "slug"
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "genders", ["slug"], :name => "index_genders_on_slug"

  create_table "images", :force => true do |t|
    t.string   "ifoto"
    t.integer  "product_id",      :null => false
    t.integer  "product_data_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "images", ["product_data_id"], :name => "index_images_on_product_data_id"
  add_index "images", ["product_id"], :name => "index_images_on_product_id"

  create_table "impressions", :force => true do |t|
    t.string   "ip_address"
    t.integer  "product_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "impressions", ["product_id"], :name => "index_impressions_on_product_id"

  create_table "marketings", :force => true do |t|
    t.string   "ad"
    t.integer  "vitrine_id", :null => false
    t.string   "slogan"
    t.string   "url"
    t.string   "banner"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "marketings", ["vitrine_id"], :name => "index_marketings_on_vitrine_id"

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "body",                        :null => false
    t.integer  "conversation_id"
    t.integer  "conversation_participant_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "messages", ["conversation_id"], :name => "index_messages_on_conversation_id"
  add_index "messages", ["conversation_participant_id"], :name => "index_messages_on_conversation_participant_id"

  create_table "orders", :force => true do |t|
    t.integer  "orderable_id"
    t.string   "orderable_type"
    t.integer  "cart_id"
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.integer  "product_id"
    t.integer  "quantity",                                         :default => 0
    t.decimal  "shipping_cost",      :precision => 9, :scale => 2
    t.string   "shipping_method"
    t.string   "transaction_status"
    t.string   "status"
    t.integer  "feedback_id"
    t.integer  "size_id"
    t.integer  "color_id"
    t.integer  "gender_id"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.integer  "condition_id"
    t.integer  "material_id"
    t.string   "track_number"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  add_index "orders", ["buyer_id"], :name => "index_orders_on_buyer_id"
  add_index "orders", ["cart_id"], :name => "index_orders_on_cart_id"
  add_index "orders", ["category_id"], :name => "index_orders_on_category_id"
  add_index "orders", ["color_id"], :name => "index_orders_on_color_id"
  add_index "orders", ["condition_id"], :name => "index_orders_on_condition_id"
  add_index "orders", ["feedback_id"], :name => "index_orders_on_feedback_id"
  add_index "orders", ["gender_id"], :name => "index_orders_on_gender_id"
  add_index "orders", ["material_id"], :name => "index_orders_on_material_id"
  add_index "orders", ["orderable_id", "orderable_type"], :name => "index_orders_on_orderable_id_and_orderable_type"
  add_index "orders", ["product_id"], :name => "index_orders_on_product_id"
  add_index "orders", ["seller_id"], :name => "index_orders_on_seller_id"
  add_index "orders", ["size_id"], :name => "index_orders_on_size_id"
  add_index "orders", ["subcategory_id"], :name => "index_orders_on_subcategory_id"

  create_table "policies", :force => true do |t|
    t.integer  "policieable_id"
    t.string   "policieable_type"
    t.string   "paypal"
    t.integer  "vitrine_id",       :null => false
    t.integer  "product_id"
    t.text     "guarantee"
    t.string   "parcelamento"
    t.string   "return"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "policies", ["vitrine_id"], :name => "index_policies_on_vitrine_id"

  create_table "product_data", :force => true do |t|
    t.string   "slug"
    t.integer  "vitrine_id",                                                  :null => false
    t.text     "detail"
    t.integer  "category_id"
    t.integer  "gender_id"
    t.integer  "subcategory_id"
    t.integer  "color_id"
    t.integer  "size_id"
    t.integer  "material_id"
    t.integer  "condition_id"
    t.integer  "brand_id"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.string   "status"
    t.string   "name"
    t.decimal  "price",          :precision => 9, :scale => 2
    t.integer  "quantity",                                     :default => 0
  end

  add_index "product_data", ["category_id"], :name => "index_product_data_on_category_id"
  add_index "product_data", ["color_id"], :name => "index_product_data_on_color_id"
  add_index "product_data", ["condition_id"], :name => "index_product_data_on_condition_id"
  add_index "product_data", ["gender_id"], :name => "index_product_data_on_gender_id"
  add_index "product_data", ["material_id"], :name => "index_product_data_on_material_id"
  add_index "product_data", ["size_id"], :name => "index_product_data_on_size_id"
  add_index "product_data", ["slug"], :name => "index_product_data_on_slug"
  add_index "product_data", ["subcategory_id"], :name => "index_product_data_on_subcategory_id"
  add_index "product_data", ["vitrine_id"], :name => "index_product_data_on_vitrine_id"

  create_table "products", :force => true do |t|
    t.integer  "vitrine_id",                                                             :null => false
    t.string   "slug"
    t.string   "name",                                                                   :null => false
    t.decimal  "price",                 :precision => 9, :scale => 2
    t.text     "detail"
    t.integer  "gender_id",                                                              :null => false
    t.integer  "category_id",                                                            :null => false
    t.integer  "subcategory_id",                                                         :null => false
    t.integer  "material_id"
    t.integer  "condition_id"
    t.integer  "size_id"
    t.integer  "color_id"
    t.integer  "brand_id"
    t.string   "meta_keywords"
    t.integer  "quantity",                                            :default => 0
    t.string   "status"
    t.string   "current_step"
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.boolean  "is_shared_on_facebook",                               :default => false
    t.boolean  "is_shared_on_twitter",                                :default => false
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"
  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["color_id"], :name => "index_products_on_color_id"
  add_index "products", ["condition_id"], :name => "index_products_on_condition_id"
  add_index "products", ["gender_id"], :name => "index_products_on_gender_id"
  add_index "products", ["material_id"], :name => "index_products_on_material_id"
  add_index "products", ["size_id"], :name => "index_products_on_size_id"
  add_index "products", ["slug"], :name => "index_products_on_slug"
  add_index "products", ["subcategory_id"], :name => "index_products_on_subcategory_id"
  add_index "products", ["vitrine_id"], :name => "index_products_on_vitrine_id"

  create_table "products_sizes", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "size_id"
  end

  add_index "products_sizes", ["product_id", "size_id"], :name => "index_products_sizes_on_product_id_and_size_id"
  add_index "products_sizes", ["product_id"], :name => "index_products_sizes_on_product_id"

  create_table "reports", :force => true do |t|
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "vitrine_id"
    t.text     "content"
    t.string   "category"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "reports", ["reportable_id", "reportable_type"], :name => "index_reports_on_reportable_id_and_reportable_type"

  create_table "send_codes", :force => true do |t|
    t.string   "account_sid"
    t.string   "auth_token"
    t.string   "client"
    t.string   "t_phone"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "send_codes", ["account_sid"], :name => "index_send_codes_on_account_sid"
  add_index "send_codes", ["auth_token"], :name => "index_send_codes_on_auth_token"
  add_index "send_codes", ["client"], :name => "index_send_codes_on_client"
  add_index "send_codes", ["t_phone"], :name => "index_send_codes_on_t_phone"

  create_table "shipmen", :force => true do |t|
    t.integer  "policy_id",   :null => false
    t.integer  "shipping_id", :null => false
    t.integer  "product_id"
    t.integer  "vitrine_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "shipmen", ["policy_id"], :name => "index_shipmen_on_policy_id"
  add_index "shipmen", ["product_id"], :name => "index_shipmen_on_product_id"
  add_index "shipmen", ["shipping_id"], :name => "index_shipmen_on_shipping_id"
  add_index "shipmen", ["vitrine_id"], :name => "index_shipmen_on_vitrine_id"

  create_table "shippings", :force => true do |t|
    t.string   "kind"
    t.string   "time"
    t.string   "option"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sizes", :force => true do |t|
    t.string   "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sizeships", :force => true do |t|
    t.integer  "product_id", :null => false
    t.integer  "size_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sizeships", ["product_id"], :name => "index_sizeships_on_product_id"
  add_index "sizeships", ["size_id"], :name => "index_sizeships_on_size_id"

  create_table "states", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subcategories", :force => true do |t|
    t.string   "slug"
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "subcategories", ["category_id"], :name => "index_subcategories_on_category_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "transactions", :force => true do |t|
    t.integer  "order_id",                                     :null => false
    t.decimal  "store_fee",      :precision => 9, :scale => 2
    t.string   "transaction_id",                               :null => false
    t.string   "status"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "transactions", ["order_id"], :name => "index_transactions_on_order_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                    :null => false
    t.string   "password_digest",                          :null => false
    t.string   "auth_token",                               :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_at"
    t.datetime "last_read_messages_at"
    t.datetime "login_at"
    t.string   "avatar"
    t.string   "banner"
    t.string   "slug"
    t.string   "name",                                     :null => false
    t.string   "surname",                                  :null => false
    t.string   "gender",                                   :null => false
    t.boolean  "banned",                :default => false
    t.string   "address"
    t.integer  "state_id"
    t.integer  "city_id"
    t.boolean  "admin",                 :default => false
    t.string   "neighborhood"
    t.string   "postal_code"
    t.string   "address_supplement"
    t.string   "ip_address"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "email_confirmed",       :default => false
    t.string   "confirm_token"
    t.string   "phone"
    t.string   "otp_secret_key"
    t.integer  "otp_counter"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "users", ["auth_token"], :name => "index_users_on_auth_token", :unique => true
  add_index "users", ["city_id"], :name => "index_users_on_city_id"
  add_index "users", ["confirm_token"], :name => "index_users_on_confirm_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["oauth_token"], :name => "index_users_on_oauth_token", :unique => true
  add_index "users", ["otp_counter"], :name => "index_users_on_otp_counter"
  add_index "users", ["otp_secret_key"], :name => "index_users_on_otp_secret_key"
  add_index "users", ["phone"], :name => "index_users_on_phone"
  add_index "users", ["slug"], :name => "index_users_on_slug"
  add_index "users", ["state_id"], :name => "index_users_on_state_id"

  create_table "views", :force => true do |t|
    t.integer  "vitrine_id", :null => false
    t.string   "ip_address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "views", ["vitrine_id"], :name => "index_views_on_vitrine_id"

  create_table "vitrines", :force => true do |t|
    t.string   "logo"
    t.string   "slug"
    t.string   "name"
    t.string   "codigo"
    t.text     "about"
    t.integer  "user_id",            :null => false
    t.string   "address"
    t.string   "neighborhood"
    t.string   "postal_code"
    t.string   "address_supplement"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "vitrines", ["slug"], :name => "index_vitrines_on_slug"
  add_index "vitrines", ["user_id"], :name => "index_vitrines_on_user_id", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], :name => "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], :name => "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
