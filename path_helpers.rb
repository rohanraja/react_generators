module PathHelpers

  def dataLoadActionsPath
    "src/actions/dataLoadActions.js"
  end

  def reducerPathForVar(redVar)
    "src/store/reducers/#{redVar}Reducer.js"
  end

  def typesPath
    "src/store/types.js"
  end

  def initStatePath
    "src/store/initialState.js"
  end

  def rootReducerPath
    "src/store/rootReducer.js"
  end

  def storyConfigPath
    ".storybook/config.js"
  end

  def comp_filepath(compFile, relative_level = -1, showExtension = true)
    outFile = "#{comp_dir(relative_level)}/#{compFile}"

    if showExtension
      return outFile
    end

    extIdx = outFile.rindex('.')
    outFile = outFile[0, extIdx]
  end

  def comp_dir(relative_level = -1)

    if relative_level == 0
      return "."
    end

    basePath = "src"
    if relative_level == 1
      basePath = ".."
    end
    
    contDir = "#{basePath}/components"


    "#{contDir}/#{@name_p}"
  end
end
