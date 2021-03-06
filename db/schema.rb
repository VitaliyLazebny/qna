# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_201_104_171_420) do
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

  create_table 'answers', force: :cascade do |t|
    t.string 'body', null: false
    t.integer 'question_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.boolean 'best', default: false
    t.index ['question_id'], name: 'index_answers_on_question_id'
    t.index ['user_id'], name: 'index_answers_on_user_id'
  end

  create_table 'authorizations', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'provider'
    t.string 'uid'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[provider uid], name: 'index_authorizations_on_provider_and_uid', unique: true
    t.index ['user_id'], name: 'index_authorizations_on_user_id'
  end

  create_table 'awards', force: :cascade do |t|
    t.string 'title'
    t.string 'url'
    t.integer 'question_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['question_id'], name: 'index_awards_on_question_id'
    t.index ['user_id'], name: 'index_awards_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.text 'commentable_type', null: false
    t.integer 'commentable_id', null: false
    t.text 'body', limit: 255
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'links', force: :cascade do |t|
    t.string 'title'
    t.string 'url'
    t.string 'linkable_type'
    t.integer 'linkable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[linkable_type linkable_id], name: 'index_links_on_linkable_type_and_linkable_id'
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'title', null: false
    t.string 'body', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_questions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'votes', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.text 'votable_type', null: false
    t.integer 'votable_id', null: false
    t.integer 'value', limit: 1
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[user_id votable_type votable_id], name: 'index_votes_on_user_id_and_votable_type_and_votable_id', unique: true
    t.index ['user_id'], name: 'index_votes_on_user_id'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'answers', 'users'
  add_foreign_key 'authorizations', 'users'
  add_foreign_key 'questions', 'users'
end
