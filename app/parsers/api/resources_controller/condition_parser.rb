module Api
  module ResourcesController
    class ConditionParser
      OPERATOR_MAP = {
        gt:       :>,
        gt_or_eq: :>=,
        eq:       :'=',
        not_eq:   :'<>',
        lt_or_eq: :<=,
        lt:       :<
      }

      def initialize(scope, field, condition)
        @scope, @field, @condition = scope, field, condition
      end

      def condition_statement
        build_condition_statement(@field, @condition)
      end

      private

      def build_condition_statement(parent_key, condition, nested = false)
        if is_a_condition?(parent_key) && !nested
          column, operator = extract_column_and_operator(parent_key)
          if column_is_boolean?(column)
            ["#{column} = ?", to_boolean(condition)]
          else
            ["#{column} = ?", condition]
          end
        else
          if nested
            column = extract_column(parent_key)
            { column => condition }
          else
            { parent_key => build_condition_statement(condition.first[0], condition.first[1], true) }
          end
        end
      end

      def is_a_condition?(obj)
        !!extract_operator(obj)
      end

      def extract_operator(obj)
        string = obj.to_s
        operator_map.each do |key, value|
          return value if string.end_with?("(#{key})")
        end
        nil
      end

      def extract_column(obj)
        obj.to_s.split("(").first
      end

      def extract_column_and_operator(string)
        if string =~ /([\.a-z_]{1,})\(([a-z_]{2,})\)/
          return $~[1], $~[2]
        end
      end

      def operator_map
        OPERATOR_MAP
      end

      def column_is_boolean?(column_name)
        @scope.columns_hash[column_name].type == :boolean
      end

      def to_boolean(string)
        ActiveRecord::ConnectionAdapters::Column.value_to_boolean(string)
      end
    end
  end
end
