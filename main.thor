require_relative 'hook_helper'
require 'tempfile'

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

    addStory(name)
  end

  desc "Add Action Creator", "Generates an action creator method, imports that in component and connects it to react"
  def actionCreator(componentName, actionCreatorName)
    say "Creating #{actionCreatorName} method for #{componentName} component", :green

    define_name_vars(componentName)
    define_component_vars

    generate_action_creator(componentName, actionCreatorName)
    add_action_import_statement(componentName, actionCreatorName)


  end

  desc "addStory", "Adds the component to the storybook for manual UI test"
  def addStory(componentName)

    say "Creating Without Props story for #{componentName} component", :green
    
    define_name_vars(componentName)
    define_component_vars


    generate_story_file(componentName)
    link_story_file(componentName)

  end

private

  def generate_story_parts
    copy_file("story/config.js", storyConfigPath, {:skip => true})
  end

  def generate_story_file(componentName)

    @storyFile = "src/stories/#{@name_l}.js"
    @comp_index_path = comp_dir(1)
    template("story/story_template.js", @storyFile)

  end

  def link_story_file(componentName)
    generate_story_parts
    req_statement = "require('../src/stories/#{@name_l}.js');"
    hooksHelper = HooksHelper.new
    hooksHelper.addLineAfterHook(storyConfigPath, "require", req_statement)
  end

  def getParsedTemplateFile(templateFile)

    temp_file = Tempfile.new("templateDummy.temp")
    template(templateFile, temp_file.path, {:force => true})
    return temp_file.path
  end


  def gen_import_statement(className, compFileName, relative_level = 1)
    import_statemeht = "import { #{className} } from '#{ comp_filepath(compFileName, relative_level, false) }'"
    return import_statemeht
  end

  def generate_action_creator(componentName, actionCreatorName)

    @actionCreatorName = actionCreatorName
    actionCreatorTemplate = "action_creator/methodTemplate.js"
    methodTempFile = getParsedTemplateFile(actionCreatorTemplate)

    hooksHelper = HooksHelper.new
    hooksHelper.addFileAfterHook(comp_filepath(@actions_file) , "new_actionCreator", methodTempFile)
  end

  def add_action_import_statement(componentName, actionCreatorName)
    imp = gen_import_statement(actionCreatorName, @actions_file, 0)
    hooksHelper = HooksHelper.new
    hooksHelper.addLineAfterHook(comp_filepath(@index_file), "import", imp)
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

  def rootReducerPath
    "src/store/rootReducer.js"
  end

  def storyConfigPath
    ".storybook/config.js"
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
    hooksHelper.addLineAfterHook(rootReducerPath, "reducerLine", @reducerDictLine)

  end

end
