require 'classifier'

TRAINING_DATA_DIR = "../test/data"
categories = {
  :computers => "#{TRAINING_DATA_DIR}/computers.txt",
  :economy   => "#{TRAINING_DATA_DIR}/economy.txt",
  :health    => "#{TRAINING_DATA_DIR}/health.txt"
}

classifiers = {
  :bayes     => Classifier::Bayes.new(*categories.keys),
  :wordscore => Classifier::WordScore.new(*categories.keys),
  :lsi       => Classifier::LSI.new
}

categories.each do |category, training_data|
  File.open(training_data) do |f|
    text = f.read
    classifiers.each do |name, classifier|
      classifier.train(category, text)
    end
  end
end

samples = [ 
  "find a medicine for cold, good for government",
  "medicine computing power for government doubles every 18 months",
  "the government raised interest rates once more"
]

classifiers.each do |name, classifier|
  puts "Using #{name}"
  samples.each do |sample|
    puts "  > #{sample}"
    puts "  * #{classifier.classify(sample)}"
    if classifier.respond_to?(:classifications)
      classifier.classifications(sample).each do |category, score|
        printf "    %10s => %4.10f\n", category, score
      end
    end
  end
end
