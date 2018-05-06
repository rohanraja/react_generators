module ComponentGen

  def component_main(componentName)
    compInitialize(componentName)

    generate_react_redux_component()
    generate_store_parts()
    linkReducer(componentName, @reducerName, @stateName)
    addStory(componentName)
  end

  def generate_react_redux_component

    template("component/index.js", comp_filepath(@index_file))
    template("component/types.js", "#{comp_dir}/types.js")
    template("component/reducers.js", comp_filepath(@reducer_file) )
    template("component/actions.js", comp_filepath(@actions_file))
    create_file("#{comp_dir}/#{@name_l}.css")
  end

  def generate_store_parts
    copy_file("store/rootReducer.js", rootReducerPath, {:skip => true})
  end

  def linkReducer(componentName, reducerName, stateVarName = "")
    if stateVarName == ""
      stateVarName = reducerName
    end

    define_name_vars(componentName)
    define_component_vars

    imp = gen_import_statement(reducerName, @reducer_file)

    @reducerDictLine = "#{stateVarName} : #{reducerName},"

    say @import_statemeht, :yellow
    say @reducerDictLine, :yellow

    hooksHelper = HooksHelper.new

    hooksHelper.addLineAfterHook(rootReducerPath, "import", imp)
    # hooksHelper.addLineAfterHook(rootReducerPath, "reducerLine", @reducerDictLine)

  end
end
