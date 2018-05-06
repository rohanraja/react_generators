module Story

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

end
