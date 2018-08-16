module DataLoad

  def dataload(reducerName, apiName)

    typeVarName = "#{reducerName}_RECEIEVED"
    typeLine = "export const #{typeVarName} = '#{typeVarName}' ;"
    addLineAfterHook("newActionType", typesPath, typeLine, "store/types.js")

    dataLoadLine = "loadDataForReducerVar(\"#{apiName}\", types.#{typeVarName})"
    addLineAfterHook("loadMethodCall", dataLoadActionsPath, dataLoadLine, "actions/dataLoadActions.js")

    actionCaseBlock = %{

    case types.#{typeVarName}:
      if(action.payload == undefined ||  Object.keys(action.payload).length == 0)
        return initialState.#{reducerName};
      return action.payload;

    }
    addLineAfterHook("actionCase", reducerPathForVar(reducerName), actionCaseBlock)

  end

end
