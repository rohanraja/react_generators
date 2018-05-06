module ActionCreator

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

end
