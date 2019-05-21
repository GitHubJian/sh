const { createTagOnBranch, publish, online } = require('../index')
const { shellPath } = require('../utils')

let tag = `rtag-${Date.now()}`
// createTagOnBranch({
//   host: '10.138.39.182',
//   root: 'root',
//   password: 'noSafeNoWork@2016',
//   shellPath: `${shellPath}sgs-pt`,
//   projectPath: '/search/odin/sgs-pt/',
//   branch: 'master',
//   tag: tag
// })

// publish({
//   host: '10.138.39.182',
//   root: 'root',
//   password: 'noSafeNoWork@2016',
//   shellPath: `${shellPath}sgs-pt`,
//   projectPath: '/search/odin/sgs-pt/',
//   branch: 'master',
//   tag: 'mtag-1557912634359',
//   pm2: 'pm2.json'
// })
init()

online({
  host: '10.138.39.182',
  root: 'root',
  password: 'noSafeNoWork@2016',
  shellPath: `${shellPath}sgs-pt`,
  projectPath: '/search/odin/sgs-pt/',
  tag: 'mtag-1557912634359'
})
