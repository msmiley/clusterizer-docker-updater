#!/usr/bin/env coffee

{ Clusterized } = require 'clusterizer'

#
# Clusterizer Module class
#
class Module extends Clusterized
  #
  # Main process function
  #
  process: (callback) ->
    @log "Hello World"
    callback()

#
# Exports
#
module.exports = Module

#
# Self-test code
#
main = ->

  { Clusterizer } = require 'clusterizer'

  x = new Clusterizer
    file: [__filename]

  if x.isMaster
    x.on 'log', (msg) ->
      console.log "main> #{msg}"
    x.on 'error', (msg) ->
      console.log "error> #{msg.stack}"

    x.start()

do main if require.main is module
