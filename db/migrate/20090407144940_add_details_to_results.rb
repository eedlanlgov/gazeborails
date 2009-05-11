class AddDetailsToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :drm, :string
    add_column :results, :jobid, :string
    add_column :results, :version, :string
    add_column :results, :params, :string
    add_column :results, :host, :string
    add_column :results, :compiler, :string
    add_column :results, :mpi, :string
    add_column :results, :duration, :string
    add_column :results, :entrytime, :datetime
    add_column :results, :numprocs, :integer
    add_column :results, :log, :string
    add_column :results, :ntkgrp, :string
  end

  def self.down
    remove_column :results, :drm
    remove_column :results, :jobid
    remove_column :results, :version
    remove_column :results, :params
    remove_column :results, :host
    remove_column :results, :compiler
    remove_column :results, :mpi
    remove_column :results, :duration
    remove_column :results, :entrytime
    remove_column :results, :numprocs
    remove_column :results, :log
    remove_column :results, :ntkgrp
  end
end
