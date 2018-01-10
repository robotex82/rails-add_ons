module Controller::QueryConditions
  private

  def add_conditions_from_query(scope)
    request.query_parameters.each do |field, condition|
      case field
      when 'sort_by', 'sort_direction', 'utf8', 'commit', 'page'
      when 'limit'
        scope = scope.limit(condition.to_i)
      when 'offset'
        scope = scope.offset(condition.to_i)
      when 'order'
        scope = scope.order(condition)
      when 'includes'
        scope = scope.includes(condition.map(&:to_sym))
      else
        condition_statement = ::Api::ResourcesController::ConditionParser.new(scope, field, condition).condition_statement
        scope = scope.where(condition_statement)
      end
    end
    scope
  end
end
