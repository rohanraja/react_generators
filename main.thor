require_relative 'hook_helper'
require_relative 'story'
require_relative 'component_base'
require_relative 'path_helpers'
require_relative 'action_creator'
require_relative 'component_gen'
require_relative 'template_helpers'
require_relative 'create_reducer'
require_relative 'data_load'
require 'tempfile'

class React < Thor
  include Thor::Actions
  include DataLoad
  include TemplateHelpers
  include ComponentBase
  include ComponentGen
  include PathHelpers
  include Story
  include ActionCreator
  include CreateReducer

  source_root File.expand_path('templates', __dir__)

  desc "Create React-Redux Component", "Define connected react component along with placeholders for actions, reducers and types"
  def component(componentName)
    component_main(componentName)
  end

  desc "Add Action Creator", "Generates an action creator method, imports that in component and connects it to react"
  def actionCreator(componentName, actionCreatorName)
    say "Creating #{actionCreatorName} method for #{componentName} component", :green
    actionCreator_main(componentName, actionCreatorName)
  end

  desc "addStory", "Adds the component to the storybook for manual UI test"
  def addStory(componentName)
    say "Creating Without Props story for #{componentName} component", :green
    addStory_main(componentName)
  end

  desc "createReducer ComponentName stateVarName", "Creates a reducer inside the component and for the state variable"
  def reducer(componentName, reducerName)
    say "Creating Reducer #{reducerName}", :green
    createReducer_main(componentName, reducerName)
  end

  desc "dataLoad reducerVar apiMethodName", "Connects reducer state with api server"
  def dataLoad(reducerName, apiMethodName)
    dataload(reducerName, apiMethodName)
  end

private

end
