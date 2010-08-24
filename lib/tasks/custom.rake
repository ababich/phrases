namespace :db do
  desc "Rebuild database from scratch using migration and db:seed fill up"
  task :rebuild => [:drop, :create, :migrate, :seed]
end
