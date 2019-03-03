# frozen_string_literal: true

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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_214_060_223) do
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.integer 'record_id', null: false
    t.integer 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'backs', force: :cascade do |t|
    t.string 'text_field'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'card_id'
  end

  create_table 'cards', force: :cascade do |t|
    t.text 'front'
    t.text 'back'
    t.integer 'deck_id'
    t.integer 'interval', default: 1
    t.integer 'ease', default: 250
    t.integer 'status'
    t.date 'day_to_study'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'decks', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'option_id'
  end

  create_table 'fronts', force: :cascade do |t|
    t.string 'text_field'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'card_id'
  end

  create_table 'options', force: :cascade do |t|
    t.string 'name'
    t.integer 'easyBonus', default: 150
    t.integer 'newInterval', default: 50
    t.integer 'intervalModifier', default: 100
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
  end

  create_table 'taggings', force: :cascade do |t|
    t.integer 'tag_id'
    t.integer 'card_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.boolean 'admin', default: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
