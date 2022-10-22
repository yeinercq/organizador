class AddTransitionsToTasks < ActiveRecord::Migration[7.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')
  def change
    add_column :tasks, :transitions, :hstore, array: true, default: []
  end
end
