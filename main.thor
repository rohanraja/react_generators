class React < Thor
  include Thor::Actions
  source_root File.expand_path('templates', __dir__)

  
  desc "Test Mathod", "example method to learn thor"
  method_option :delete, :aliases => "-d", :desc => "Delete the file after parsing it"
  def test()
    @name = "Rohan"
    template("simplefile.rb", "files/morefiles/simplefile.rb")
  end



  desc "Create React-Redux Component", ""
  def component(name)

    define_name_vars(name)

    template("component/index.js", "#{@comp_dir}/index.js")
    template("component/types.js", "#{@comp_dir}/types.js")
    template("component/reducers.js", "#{@comp_dir}/reducers.js")
    template("component/actions.js", "#{@comp_dir}/actions.js")
    create_file("#{@comp_dir}/#{@name_l}.css")
  end

private

  def define_name_vars(name)
    
    @name_p = name.capitalize
    @name_l = name.downcase

    @comp_dir = "src/components/#{@name_p}"

  end

end
