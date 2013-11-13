task :import_cta_train_data do 
  CTA::TrainTracker.key = ENV['CTA_TRAIN_API_KEY']
  
end