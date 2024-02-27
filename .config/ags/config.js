const entry = App.configDir + '/ts/main.ts'
const outdir = '/tmp/ags/js'
const scss = `${App.configDir}/style/style.scss`
const css = `/tmp/my-style.css`

const liveReload = true

const reloadCss = () => {
  // compile, reset, apply
  Utils.exec(`sassc ${scss} ${css}`)
  App.resetCss()
  App.applyCss(css)
}

if (liveReload) {
  Utils.monitorFile(
    // directory that contains the scss files
    `${App.configDir}/style`,

    // reload function
    reloadCss,
  )
} else {
  Utils.exec(`sassc ${scss} ${css}`)
}

// Utils.exec(`sassc ${scss} ${css}`)

try {
  await Utils.execAsync([
    'bun', 'build', entry,
    '--outdir', outdir,
    '--external', 'resource://*',
    '--external', 'gi://*',
  ])
} catch (error) {
  console.error(error)
}

const main = await import(`file://${outdir}/main.js`)

export default {
  style: css,
  windows: [main.default]
}
