module ActionComponent

  def actComp(compName, actName, fileName)
    compInitialize(compName)
    addAction(actName, fileName)
    importToComponent(compName, actName, fileName)
    addDispatchCall(compName, actName)
  end

  def addDispatchCall(compName, actName)

    dp = "#{actName} : () => dispatch(#{actName}()),"
    addLineAfterHook("dispatch", comp_filepath(@index_file), dp) 
  end

  def importToComponent(compName, actName, fileName)
    imp = "import {#{actName}} from '../../actions/#{fileName}' ;"
    addLineAfterHook("import", comp_filepath(@index_file), imp) 

  end

  def addAction(actName, fileName)
    actMethod = %{
export function #{actName}() {

  return function (dispatch, getState) {
    const state = getState();

  };
}
    }

    addLineAfterHook("action", "src/actions/#{fileName}.js", actMethod) 
  end

end
