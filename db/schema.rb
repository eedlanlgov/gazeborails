# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090407173935) do

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes_results", :id => false, :force => true do |t|
    t.integer "node_id"
    t.integer "result_id"
  end

  create_table "results", :force => true do |t|
    t.string   "name"
    t.boolean  "result"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "drm"
    t.string   "version"
    t.string   "params"
    t.string   "host"
    t.string   "compiler"
    t.string   "mpi"
    t.string   "duration"
    t.datetime "entrytime"
    t.integer  "numprocs"
    t.string   "log"
    t.string   "ntkgrp"
    t.integer  "jobid"
  end

  add_index "results", ["name"], :name => "index_results_on_name"

  create_table "results_segments", :id => false, :force => true do |t|
    t.integer "result_id"
    t.integer "segment_id"
  end

  create_table "segments", :force => true do |t|
    t.string   "name"
    t.string   "arch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trend_datas", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.string   "units"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "result_id"
  end

  add_index "trend_datas", ["name"], :name => "index_trend_datas_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "pw"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

end
