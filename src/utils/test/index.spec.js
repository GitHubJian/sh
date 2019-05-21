const { rsync, write } = require('../index')

;(async () => {
  await write('tag.sh')

  await write('publish.sh')

  await write('online.sh', {
    host: `"10.142.38.229"`,
    root: `"root"`,
    password: `"noSafeNoWork@2014"`,
    path: `"/search/odin/sgs-pt/"`
  })

  await write('online.exp')

  await write('online.batch.sh', {
    hostArray: `"10.153.53.220"`,
    rootArray: `"root"`,
    passwordArray: `"noSafeNoWork@2016"`,
    pathArray: `"/search/odin/sgs-pt/"`
  })

  await write('rsync.exp')

  await rsync('10.138.39.182', 'root', 'noSafeNoWork@2016', 'sgs-pt')
})()
