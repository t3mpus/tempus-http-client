class Project extends require('../base')

  resource: "projects"

module.exports = (ops)->
  new Project ops
