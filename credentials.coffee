creds = null

valid = (c) ->
  c?.secret and c?.user_identifier


module.exports =

  set: (c)->
    if valid c
      creds = c
    else
      throw new Error 'Invalid credentials'

  get: ()->
    if valid creds
      return {
        key: creds.secret
        id: creds.user_identifier
        algorithm: 'sha256'
      }
    else
      return null
