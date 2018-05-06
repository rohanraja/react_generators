module ComponentBase
  include Thor::Actions

  def define_component_vars()
    @reducer_file = "reducers.js"
    @actions_file = "actions.js"
    @index_file = "index.js"


    @reducerName = "#{@name_p}Reducer"
    @stateName = @name_l

  end

  def define_name_vars(name)
    
    @name_p = name.capitalize
    @name_l = name.downcase

  end

end
