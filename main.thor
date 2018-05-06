require_relative 'hook_helper'

class React < Thor
  include Thor::Actions
  source_root File.expand_path('templates', __dir__)

  desc "Create React-Redux Component", "Define connected react component along with placeholders for actions, reducers and types"
  def component(name)

    define_name_vars(name)
    define_component_vars

    generate_react_redux_component()
    generate_store_parts()

    linkReducer(name, @reducerName, @stateName)
  end

private

  def generate_react_redux_component

    template("component/index.js", "#{comp_dir}/index.js")
    template("component/types.js", "#{comp_dir}/types.js")
    template("component/reducers.js", comp_filepath(@reducer_file) )
    template("component/actions.js", "#{comp_dir}/actions.js")
    create_file("#{comp_dir}/#{@name_l}.css")
  end

  def generate_store_parts
    copy_file("store/rootReducer.js", rootReducerPath, {:skip => true})
  end

  def comp_filepath(compFile, relative_level = -1, showExtension = true)
    outFile = "#{comp_dir(relative_level)}/#{@reducer_file}"

    if showExtension
      return outFile
    end

    extIdx = outFile.rindex('.')
    outFile = outFile[0, extIdx]
  end

  def comp_dir(relative_level = -1)

    basePath = "src"
    if relative_level == 1
      basePath = ".."
    end
    "#{basePath}/components/#{@name_p}"
  end


  def define_component_vars()
    @reducer_file = "reducers.js"
    @reducerName = "#{@name_p}Reducer"
    @stateName = @name_l

  end

  def define_name_vars(name)
    
    @name_p = name.capitalize
    @name_l = name.downcase

  end

  def rootReducerPath
    "src/store/rootReducer.js"
  end

  def linkReducer(componentName, reducerName, stateVarName = "")
    if stateVarName == ""
      stateVarName = reducerName
    end

    define_name_vars(componentName)
    define_component_vars

    @import_statemeht = "import { #{reducerName} } from '#{ comp_filepath(@reducer_file, 1, false) }'"

    @reducerDictLine = "#{stateVarName} : #{reducerName},"

    say @import_statemeht, :yellow
    say @reducerDictLine, :yellow

    hooksHelper = HooksHelper.new

    hooksHelper.addLineAfterHook(rootReducerPath, "import", @import_statemeht)
    hooksHelper.addLineAfterHook(rootReducerPath, "reducerLine", @reducerDictLine)

  end

end
