desc 'sets up the database and search index or runs the migrations'
task deploy: :environment do
  if ActiveRecord::SchemaMigration.table_exists?
    Rake::Task['db:migrate'].invoke
  else
    Rake::Task['db:schema:load'].invoke
    Rake::Task['es:indices:create'].invoke
  end
end
