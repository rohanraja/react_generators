import initialState from '../initialState'
import * as types from '../types'
// -- import_hook --

export function <%= @reducerName %>(state = initialState.<%= @stateVar %>, action) {
  switch (action.type) {

    default:
      return state
  }
}

