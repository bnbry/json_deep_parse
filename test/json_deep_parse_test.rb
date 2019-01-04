require "test_helper"

class JSONDeepParseTest
  class Integration < Minitest::Test
    module JSONDeepParser
      using JSONDeepParse

      def self.deep_parse(json_blob)
        JSON.deep_parse(json_blob)
      end
    end

    def test_it_still_raises_parser_error_on_invalid_initial_json
      assert_raises(JSON::ParserError) { JSONDeepParser.deep_parse("hello") }
    end

    def test_it_parses_simple_json
      simple_json = <<~SIMPLE_JSON
        {
          "name": "R0B",
          "age": 7,
          "types": {
            "robot": true,
            "shark": false
          },
          "skills": ["hacks", "baking"]
        }
      SIMPLE_JSON

      result = JSONDeepParser.deep_parse(simple_json)

      assert_equal("R0B", result.fetch("name"))
      assert_equal(7, result.fetch("age"))
      assert(result.dig("types", "robot"))
      refute(result.dig("types", "shark"))
      assert_equal(["baking", "hacks"].sort, result.fetch("skills").sort)
    end

    def test_it_deeply_parses_complex_json
      deeply_nested_json = "{\"nested_example\":[\"{\\\"helpers\\\":\\\"{\\\\\\\"name\\\\\\\":\\\\\\\"Chomp\\\\\\\",\\\\\\\"age\\\\\\\":3,\\\\\\\"types\\\\\\\":{\\\\\\\"robot\\\\\\\":false,\\\\\\\"shark\\\\\\\":true},\\\\\\\"skills\\\\\\\":[\\\\\\\"swimming\\\\\\\",\\\\\\\"gardening\\\\\\\"]}\\\"}\"]}"

      result = JSONDeepParser.deep_parse(deeply_nested_json)
      deep_result = result.fetch("nested_example").first.fetch("helpers")

      assert_equal("Chomp", deep_result.fetch("name"))
      assert_equal(3, deep_result.fetch("age"))
      assert(deep_result.dig("types", "shark"))
      refute(deep_result.dig("types", "robot"))
      assert_equal(["swimming", "gardening"].sort, deep_result.fetch("skills").sort)
    end
  end

  class Isolation < Minitest::Test
    using JSONDeepParse

    def test_parses_array_by_parsing_each_value
      input = ["hello", "{ \"robot\":\"shark\" }"]

      result = input.deep_parse

      assert_equal("hello", result.first)
      assert_equal("shark", result.last.fetch("robot"))
    end

    def test_parses_false_by_returning_self
      refute(false.deep_parse)
    end

    def test_parses_basic_hash_by_parsing_each_value
      result = { robot: "shark" }.deep_parse

      assert_equal("shark", result.fetch(:robot))
    end

    def test_parses_complex_hash_by_parsing_each_value
      result = { "stuff" => { "things" => "{ \"robot\":\"shark\" }" } }.deep_parse

      assert_equal("shark", result.dig("stuff", "things", "robot"))
    end

    def test_parses_nil_by_returning_self
      assert_nil(nil.deep_parse)
    end

    def test_parses_numeric_by_returning_self
      assert_equal(5, 5.deep_parse)
      assert_equal(7.9, 7.9.deep_parse)
    end

    def test_parses_non_json_string_by_returning_self
      assert_equal("hello", "hello".deep_parse)
    end

    def test_parses_json_string_by_actually_parsing
      result = "{ \"robot\":\"shark\", \"missing_value\":null }".deep_parse

      assert_equal("shark", result.fetch("robot"))
      assert_nil(result.fetch("missing_value"))
    end

    def test_parses_trueclass_by_returning_self
      assert(true.deep_parse)
    end
  end
end
