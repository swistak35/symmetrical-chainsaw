import { combineReducers } from 'redux'
import { routerReducer as router } from 'react-router-redux'
import counter from './modules/counter'
import links from './modules/links'

export default combineReducers({
  counter,
  links,
  router
})
