class TimeEntry extends require('../base')

  resource: "time_entries"

module.exports = (ops)->
  new TimeEntry ops
