# Docker Updater Clusterizer Module

A [Clusterizer](https://www.npmjs.com/package/clusterizer) Module which checks Docker Hub for updates to specified images.

Warning: work in progress

## Installation

```bash
$ npm install clusterizer-docker-updater
```

## Usage

Load this module using [Clusterizer](https://www.npmjs.com/package/clusterizer) and set an agenda to check for updates:

```coffee

clusterizer = new Clusterizer
  logging: true
  npm: ["clusterizer-docker-updater"]

if clusterizer.isMaster
  # error handler
  clusterizer.on 'error', (err, module) ->
    console.log "main> Error in #{module}: #{err.stack}"

  # configure clusterizer-docker-updater
  clusterizer.send 'docker.setup',
    socketPath: '/var/run/docker.sock' # use socketPath
    host: '192.168.0.4'                # - or -
    port: 3000                         # host + port
    token: '<insert token>'
  , 'clusterizer-docker-updater'
  clusterizer.send 'docker.image.add', 'dockerfile/ubuntu', 'clusterizer-docker-updater'

  # set agenda for clusterizer-docker-updater to check for update once a day
  clusterizer.setAgenda 'localhost:27017/test', '1 day', 'clusterizer-docker-updater'

  # handler for message that update is available
  clusterizer.on 'docker.image.update', (msg, module) ->
    console.log "update is available for Docker image: #{msg.image}"
    console.log "build: #{msg.buildId}"
    console.log "date: #{msg.lastUpdated}"

```


## Testing

```bash
$ npm test
```

## License

  [MIT](LICENSE)
