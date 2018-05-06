module TemplateHelpers

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
