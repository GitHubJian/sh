const root = process.cwd()
const fse = require('fs-extra')
const path = require('path')
const ejs = require('ejs')
const { exec } = require('child_process')

const defaultCallbacks = {
  stdout: function(e) {
    console.log(e)
  },
  stderr: function(e) {
    console.log(e)
  },
  close: function(e) {
    console.log(e)
  }
}

const sourcePath = path.resolve(root, 'src/source')
const targetPath = path.resolve(root, '.temp/target')

exports.shellPath = '/search/odin/.sh/'

exports.localShellPath = __dirname

exports.rsync = async function(
  { host, root, password, path },
  callbacks = defaultCallbacks
) {
  let { stdout, stderr, close } = callbacks

  let ls = exec(
    `expect ${__dirname}/rsync.sh ${host} ${root} ${password} ${
      exports.shellPath
    }${path}`
  )

  ls.stdout.on('data', function(data) {
    stdout && stdout(data)
  })

  ls.stderr.on('data', function(data) {
    stderr && stderr(data)
  })

  ls.on('close', function(code) {
    close && close(code)
  })
}

const encoding = 'utf-8'
exports.write = async function(filename, data = {}) {
  fse.ensureDirSync(targetPath)

  let file = fse.readFileSync(path.resolve(sourcePath, filename), { encoding })
  let targetFilePath = path.resolve(targetPath, filename)

  let targetFile = ejs.render(file, data)

  fse.writeFileSync(targetFilePath, targetFile, { encoding })
}

exports.execa = function(cmd, callbacks = defaultCallbacks) {
  let { stdout, stderr, close } = callbacks

  let ls = exec(cmd)

  ls.stdout.on('data', function(data) {
    stdout && stdout(data)
  })

  ls.stderr.on('data', function(data) {
    stderr && stderr(data)
  })

  ls.on('close', function(code) {
    close && close(code)
  })
}
