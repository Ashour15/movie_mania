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

ActiveRecord::Schema.define(version: 2024_06_19_070426) do

  create_table "actors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_actors_on_name", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "directors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_directors_on_name", unique: true
  end

  create_table "filming_locations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_filming_locations_on_name", unique: true
  end

  create_table "movie_actors", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "actor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["actor_id"], name: "index_movie_actors_on_actor_id"
    t.index ["movie_id", "actor_id"], name: "index_movie_actors_on_movie_id_and_actor_id", unique: true
    t.index ["movie_id"], name: "index_movie_actors_on_movie_id"
  end

  create_table "movie_filming_locations", id: false, force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "filming_location_id", null: false
    t.index ["filming_location_id"], name: "index_movie_filming_locations_on_filming_location_id"
    t.index ["movie_id", "filming_location_id"], name: "index_movie_locations_on_movie_and_location", unique: true
    t.index ["movie_id"], name: "index_movie_filming_locations_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "year"
    t.integer "director_id", null: false
    t.integer "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_movies_on_country_id"
    t.index ["director_id"], name: "index_movies_on_director_id"
    t.index ["title"], name: "index_movies_on_title", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "movie_id", null: false
    t.integer "stars"
    t.text "review"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_reviews_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "movie_actors", "actors"
  add_foreign_key "movie_actors", "movies"
  add_foreign_key "movie_filming_locations", "filming_locations"
  add_foreign_key "movie_filming_locations", "movies"
  add_foreign_key "movies", "countries"
  add_foreign_key "movies", "directors"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "users"
end
