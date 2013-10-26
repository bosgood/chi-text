namespace :db do
  task :import_csv, [:csv_path] => :environment do |t, args|
    puts args.csv_path
  end
end