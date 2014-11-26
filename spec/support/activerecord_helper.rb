class ActiveRecordHelper
  ActiveRecord::Migrator.migrate(File.join(Rails.root, 'db/migrate'))
end
