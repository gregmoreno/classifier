require 'classifier'

TRAINING_DATA_DIR = "../test/data"
categories = {
  'computers' => "#{TRAINING_DATA_DIR}/computers.txt",
  'economy'   => "#{TRAINING_DATA_DIR}/economy.txt",
  'health'    => "#{TRAINING_DATA_DIR}/health.txt"
}


classifiers = {
  :bayes     => Classifier::Bayes.new(*categories.keys),
  :wordscore => Classifier::WordScore.new(*categories.keys)
}

categories.each do |category, training_data|
  File.open(training_data) do |f|
    classifiers.each do |name, classifier|
      classifier.train(category, f.read)
    end
  end
end

samples = [ 
  "we will someday find a medicine for cold",
  "computing power doubles every 18 months",
  "the government raised interest rates once more"
]

classifiers.each do |name, classifier|
  puts "Using #{name}"
  samples.each do |sample|
    puts sample
    puts "  #{classifier.classify(sample)}"
  end
end
