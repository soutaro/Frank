require "frank-cucumber/frank_helper"
require "active_support/core_ext/array/extract_options"

module Frank
  class Frankly < BasicObject
    attr_reader :selector

    def initialize(selector)
      @selector = selector

      @helper = ::Object.new

      class <<@helper
        include ::Frank::Cucumber::FrankHelper
      end
    end

    def __map__(*args)
      selector = self.selector

      @helper.instance_eval do
        frankly_map(selector, *args)
      end
    end

    def method_missing(method_name, *args)
      options = args.extract_options!

      case
      when args.size == 0
        method_selector = method_name.to_s
        parameters = []
      when options.size == 0
        method_selector = method_name.to_s + ":"
        parameters = args
      else
        method_selector = method_name.to_s + ":" + options.keys.join(':') + ":"
        parameters = args + options.values
      end

      __map__(method_selector, *parameters)
    end
  end

  module Cucumber
    module FrankHelper
      def Frankly(selector)
        ::Frank::Frankly.new(selector)
      end
    end
  end
end