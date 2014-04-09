class TimeEntry extends require('../base')

  resource: "time_entries"
  belongs_to: "project"

module.exports = (ops)->
  new TimeEntry ops
