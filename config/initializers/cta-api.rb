key = ENV['CTA_TRAIN_API_KEY']

CTA::TrainTracker.key = key unless key.nil?
