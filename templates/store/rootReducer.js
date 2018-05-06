import { combineReducers } from 'redux'
import { lineIncReducer } from '../components/controlpanel/reducers'
import { SampleReducer } from '../components/Listview/reducers'
import { SampleReducer } from '../components/Listview/reducers'
// -- import_hook -- 

export const rootReducer = combineReducers({
  activeLineNo: lineIncReducer,
  ival : SampleReducer,
  ival : SampleReducer,
  // -- reducerLine_hook -- 
})

