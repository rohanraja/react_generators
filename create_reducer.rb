module CreateReducer

  def createReducer_main(componentName, reducerName)

    compInitialize(componentName)

    @stateVar = reducerName
    @reducerName = "#{reducerName}Reducer"
    generate_reducer(componentName, @reducerName)
    linkReducer(componentName, @reducerName, @stateVar)

  end

  def generate_reducer(componentName, reducerName)

    tmpFile = "reducer/methodTemplate.js"
    methodTempFile = getParsedTemplateFile(tmpFile)

    hooksHelper = HooksHelper.new
    hooksHelper.addFileAfterHook(comp_filepath(@reducer_file) , "newmethod", methodTempFile)
  end


  def linkReducer(componentName, reducerName, stateVarName = "")

    say "Linking reducer #{reducerName} to combineReducer"
    imp = gen_import_statement(reducerName, @reducer_file)
    hooksHelper = HooksHelper.new
    hooksHelper.addLineAfterHook(rootReducerPath, "import", imp)

    if stateVarName != ""
      @reducerDictLine = "#{stateVarName} : #{reducerName},"
      hooksHelper.addLineAfterHook(rootReducerPath, "reducerLine", @reducerDictLine)
    end

  end
end
