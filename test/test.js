/* global describe, it */

var assert = require('assert')
var fs = require('fs')
var parse = require('..').parse
var serialize = require('..').serialize

describe('smiles', function () {
  var exampleFiles = [
    'aliphaticorganic',
    'aromaticorganic',
    'elementsymbol',
    'isotope',
    'aromaticsymbol',
    'chiral',
    'hydrogencount',
    'charge',
    'class',
    'bond',
    'ringbond',
    'branch',
    'dot-bond',
    'test-001',
    'test-002'
  ]

  var examples = exampleFiles.map(function (exampleFile) {
    return JSON.parse(fs.readFileSync('test/' + exampleFile + '.json').toString())
  })

  describe('parser', function () {
    examples.forEach(function (example) {
      it('should parse ' + example.label + ' SMILES string', function () {
        var actual = parse(example.smiles)
        var expected = example.tokens

        assert.deepEqual(actual, expected)
      })
    })
  })

  describe('serializer', function () {
    examples.forEach(function (example) {
      it('should serialize ' + example.label + ' SMILES string', function () {
        var actual = serialize(example.tokens)
        var expected = example.smiles

        assert.deepEqual(actual, expected)
      })
    })
  })
})
