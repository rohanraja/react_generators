import initialState from '../initialState'
import * as types from '../types'
// -- import_hook --

export function <%= @reducerName %>(state = initialState.<%= @stateVar %>, action) {
  switch (action.type) {

    // -- actionCase_hook --

    default:
      return state
  }
}

