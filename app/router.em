`import Em from 'ember'`
`import config from './config/environment'`

class Router extends Em.Router
  location: config.locationType

Router.map ->
  @route 'badge', path: '/'

`export default Router`
