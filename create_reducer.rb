module CreateReducer

  def createReducer_main(componentName, reducerName)

    compInitialize(componentName)

    @stateVar = reducerName
    @reducerName = "#{reducerName}Reducer"
    generate_reducer(componentName, @reducerName)
    linkReducer(componentName, @reducerName, @stateVar)
    initState(componentName, @reducerName, @stateVar)

  end

  def generate_reducer(componentName, reducerName)

    tmpFile = "reducer/methodTemplate.js"
    @reducerFilePath = "src/store/reducers/#{@reducerName}.js"

    template(tmpFile, @reducerFilePath)
  end


  def linkReducer(componentName, reducerName, stateVarName = "")

    say "Linking reducer #{reducerName} to combineReducer"
    # imp = gen_import_statement(reducerName, @reducer_file)
    imp = "import { #{reducerName} } from './reducers/#{reducerName}'" 
    hooksHelper = HooksHelper.new
    hooksHelper.addLineAfterHook(rootReducerPath, "import", imp)

    if stateVarName != ""
      @reducerDictLine = "#{stateVarName} : #{reducerName},"
      hooksHelper.addLineAfterHook(rootReducerPath, "reducerLine", @reducerDictLine)
    end

  end
  def initState(componentName, reducerName, stateVarName = "")
    say "Adding to initialState.js "

    hooksHelper = HooksHelper.new
    if stateVarName != ""
      @reducerDictLine = "#{stateVarName} : {},"
      hooksHelper.addLineAfterHook(initStatePath, "initialState", @reducerDictLine)
    end
  end

  def generate_reducer_OLD(componentName, reducerName)

    tmpFile = "reducer/methodTemplate.js"
    methodTempFile = getParsedTemplateFile(tmpFile)

    hooksHelper = HooksHelper.new
    hooksHelper.addFileAfterHook(comp_filepath(@reducer_file) , "newmethod", methodTempFile)
  end


  def linkReducer_OLD(componentName, reducerName, stateVarName = "")

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
