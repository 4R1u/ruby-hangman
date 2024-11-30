# frozen_string_literal: true

words_file = File.open('resources/google-10000-english-no-swears.txt')
words = []
while (line = words_file.gets)
  words << line.chomp
end
