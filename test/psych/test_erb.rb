require 'psych/helper'

module Psych
  class TestERB < TestCase
    require 'erb'

    def test_erb_result_of_erb_dump
      erb  = "<%= 'a' %>"
      erb2  = Psych.dump(erb)
      assert_equal "--- a\n...\n", ERB.new(erb2).result  #unquoted string a and trailing newline ellipsis and newline???
    end

    def test_erb_round_trip_string_leading_percent
      erb   = "<%= '%Joe' %>"
      erb2  = Psych.load(ERB.new(Psych.dump(erb)).result)
      assert_equal '%Joe', erb2
    end

    def test_erb_round_trip_string_leading_exclamation
      erb   = "<%= '!#Joe' %>"
      erb2  = Psych.load(ERB.new(Psych.dump(erb)).result)
      assert_equal '!#Joe', erb2
    end

    def test_erb_round_trip_string_leading_ampersand
      erb   = "<%= '@Joe' %>"
      erb2  = Psych.load(ERB.new(Psych.dump(erb)).result)
      assert_equal '@Joe', erb2
    end
  end
end
