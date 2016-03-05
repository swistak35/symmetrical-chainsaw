/* @flow */

export const LINK_ADD = 'LINK_ADD'

export function addLink (url: string) : Action {
  return {
    type: LINK_ADD,
    payload: {
      url: url
    }
  }
}

export const actions = {
  addLink
}

const ACTION_HANDLERS = {
  [LINK_ADD]: (state: number, action: {payload: { url: string }}): Array<string> => state.concat([ action.payload.url ])
}

const initialState = []

export default function linksReducer (state: links = initialState, action: Action): Array<string> {
  const handler = ACTION_HANDLERS[action.type]

  return handler ? handler(state, action) : state
}
