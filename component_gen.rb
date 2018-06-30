module ComponentGen

  def component_main(componentName)
    compInitialize(componentName)

    generate_react_redux_component()
    # generate_store_parts()
    # linkReducer(componentName, @reducerName, @stateName)
    addStory(componentName)
  end

  def generate_react_redux_component

    template("component/index.js", comp_filepath(@index_file))
    # template("component/types.js", "#{comp_dir}/types.js")
    # template("component/reducers.js", comp_filepath(@reducer_file) )
    # template("component/actions.js", comp_filepath(@actions_file))
    create_file("#{comp_dir}/#{@name_l}.css")
  end

  def generate_store_parts
    copy_file("store/rootReducer.js", rootReducerPath, {:skip => true})
  end

end
