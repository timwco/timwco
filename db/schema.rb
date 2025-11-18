# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_18_160752) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "albums", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "order"
    t.jsonb "spotify_data"
    t.string "spotify_id"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "assets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["filename"], name: "index_assets_on_filename", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "collections", force: :cascade do |t|
    t.integer "collection_type", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "collection_type"], name: "index_collections_on_name_and_collection_type", unique: true
  end

  create_table "contents", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.string "key", null: false
    t.boolean "raw_text", default: false, null: false
    t.text "rendered_html"
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_contents_on_key", unique: true
  end

  create_table "links", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.index ["collection_id"], name: "index_links_on_collection_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "abstract"
    t.bigint "category_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "estimated_reading_time"
    t.bigint "featured_image_id"
    t.date "published_date"
    t.text "rendered_html"
    t.string "slug", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["featured_image_id"], name: "index_posts_on_featured_image_id"
    t.index ["published_date"], name: "index_posts_on_published_date"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "speaking_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "event_date"
    t.string "event_name"
    t.string "name"
    t.datetime "updated_at", null: false
    t.string "url"
  end

  create_table "tools", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.index ["collection_id"], name: "index_tools_on_collection_id"
  end

  create_table "wishlist_items", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "price", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.index ["collection_id"], name: "index_wishlist_items_on_collection_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "links", "collections"
  add_foreign_key "posts", "assets", column: "featured_image_id"
  add_foreign_key "posts", "categories"
  add_foreign_key "tools", "collections"
  add_foreign_key "wishlist_items", "collections"
end
