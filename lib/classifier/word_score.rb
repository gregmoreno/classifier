# Author::    Greg Moreno (mailto:rubyoncloud@gmail.com)
# Copyright:: Copyright (c) 2010 Greg Moreno
# License::   LGPL

module Classifier

  # I really feel that WordScore shouldn't inherit from Bayes.
  # But for now, this will do
  class WordScore < Bayes

    # Returns the score in each category for the given +text+
    # TODO: cache +total+ after everyt training
    def classifications(text)
      score = Hash.new
      @categories.each do |category, category_words|
        score[category.to_s] = 0
        total = category_words.values.inject(0) { |sum, element| sum + element }

        text.word_hash.each do |word, count|
          if freq = category_words[word]
            score[category.to_s] +=  (freq / total.to_f) * count
          end
        end
      end

      score
    end

  end # class WordScore

end
