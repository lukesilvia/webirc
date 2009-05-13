# -*- coding: utf-8 -*-
class StringUtility
  class << self
    def to_words(text)
      text.gsub(/　/, ' ').strip.split(/\s+/)
    end
  end
end
