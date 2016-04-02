var parser = require('./lib/parser')
var serializer = require('./lib/serializer')

module.exports = {
  parse: parser.parse,
  parser: parser,
  serialize: serializer.serialize,
  serializer: serializer
}
