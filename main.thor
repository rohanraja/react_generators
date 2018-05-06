require_relative 'hook_helper'
require_relative 'story'
require_relative 'component_base'
require_relative 'path_helpers'
require_relative 'action_creator'
require_relative 'component_gen'
require 'tempfile'

class React < Thor
  include Thor::Actions
  include ComponentBase
  include ComponentGen
  include PathHelpers
  include Story
  include ActionCreator

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

  def getParsedTemplateFile(templateFile)

    temp_file = Tempfile.new("templateDummy.temp")
    template(templateFile, temp_file.path, {:force => true})
    return temp_file.path
  end


  def gen_import_statement(className, compFileName, relative_level = 1)
    import_statemeht = "import { #{className} } from '#{ comp_filepath(compFileName, relative_level, false) }'"
    return import_statemeht
  end

end
