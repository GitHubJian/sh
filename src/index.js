const { execa, localShellPath, write, rsync } = require('./utils')

exports.createTagOnBranch = function(
  { host, root, password, shellPath, projectPath, branch, tag },
  callbacks
) {
  let cmd = `expect ${localShellPath}/execa.tag.sh ${host} ${root} ${password} ${shellPath} ${projectPath} ${branch} ${tag}`

  execa(cmd, callbacks)
}

exports.publish = function(
  { host, root, password, shellPath, projectPath, pm2, branch, tag },
  callbacks
) {
  let cmd = `expect ${localShellPath}/execa.publish.sh ${host} ${root} ${password} ${shellPath} ${projectPath} ${pm2} ${branch} ${tag}`

  execa(cmd, callbacks)
}

// 预发布环境的信息
exports.online = function(
  { host, root, password, shellPath, projectPath, tag },
  callbacks
) {
  let cmd = `expect ${localShellPath}/execa.online.sh ${host} ${root} ${password} ${shellPath} ${projectPath} ${tag}`

  execa(cmd, callbacks)
}

exports.batchOnline = function(
  { host, root, password, shellPath, projectPath, tag },
  callbacks
) {
  let cmd = `expect ${localShellPath}/execa.online.batch.sh ${host} ${root} ${password} ${shellPath} ${projectPath} ${tag}`

  execa(cmd, callbacks)
}

exports.init = async function(stage, online, prodList, callback) {
  try {
    await write('tag.sh')

    await write('publish.sh')

    await write('online.sh', online)

    await write('online.exp')

    let onlineBatchObj = convert(prodList)

    await write('online.batch.sh', onlineBatchObj)

    await write('rsync.exp')

    await rsync(stage)

    callback && callback('init success')
  } catch (err) {
    callback && callback(err)
  }
}

function convert(prodList) {
  let onlineBatch = prodList.reduce(
    (prev, cur) => {
      prev.hostArray.push(cur.host)
      prev.rootArray.push(cur.root)
      prev.passwordArray.push(cur.password)
      prev.pathArray.push(cur.path)

      return prev
    },
    {
      hostArray: [],
      rootArray: [],
      passwordArray: [],
      pathArray: []
    }
  )

  let onlineBatchObj = Object.entries(onlineBatch).reduce((prev, [k, v]) => {
    prev[k] = v.map(v => `"${v}"`).join(' ')

    return prev
  }, {})
  
  return onlineBatchObj
}

exports.init(
  {
    host: '10.138.39.182',
    root: 'root',
    password: 'noSafeNoWork@2016',
    project: 'sgs-pt'
  },
  {
    host: `"10.142.38.229"`,
    root: `"root"`,
    password: `"noSafeNoWork@2014"`,
    path: `"/search/odin/sgs-pt/"`
  },
  [
    {
      host: '10.153.53.220',
      root: 'root',
      password: 'noSafeNoWork@2016',
      path: '/search/odin/sgs-pt/'
    }
  ]
)
