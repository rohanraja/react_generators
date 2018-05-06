import initialState from '../../store/initialState'
import * as types from './types'
// -- import_hook --

export function <%= @reducerName %>(state = initialState, action) {
  switch (action.type) {

    default:
      return state
  }
}

// -- newmethod_hook --
