require "json"
require "json_deep_parse/version"

# Refinement for extending JSON with #deep_parse functionality
#
# Valid JSON can only map to a fixed set of objects in Ruby so we
# can easily define a solution for each potential value of a valid
# JSON object while attempting to reparse any strings that are found
# that may be potentially deeply escaped JSON.
module JSONDeepParse
  unless JSON.respond_to?(:deep_parse)
    refine Array do
      def deep_parse
        map { |value| value.deep_parse }
      end
    end

    refine FalseClass do
      def deep_parse
        self
      end
    end

    refine Hash do
      def deep_parse
        map { |key, value| [key, value.deep_parse] }.to_h
      end
    end

    refine JSON.singleton_class do
      def deep_parse(payload)
        parse(payload).deep_parse
      end
    end

    refine NilClass do
      def deep_parse
        self
      end
    end

    refine Numeric do
      def deep_parse
        self
      end
    end

    refine String do
      def deep_parse
        JSON.deep_parse(self)
      rescue JSON::ParserError
        self
      end
    end

    refine TrueClass do
      def deep_parse
        self
      end
    end
  end
end
