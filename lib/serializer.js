function serializeToken (token) {
  switch (token.type) {
    case 'BracketAtom':
      return token.value === 'begin' ? '[' : ']'
    case 'Branch':
      return token.value === 'begin' ? '(' : ')'
    case 'Charge':
      if (token.value === 1) {
        return '+'
      } else if (token.value === -1) {
        return '-'
      } else if (token.value > 0) {
        return '+' + token.value
      } else {
        return token.value
      }
    case 'Chiral':
      return token.value === 'anticlockwise' ? '@' : '@@'
    case 'Class':
      return ':' + token.value
    case 'HydrogenCount':
      return 'H' + (token.value !== 1 ? token.value : '')
    case 'Ringbond':
      return token.value < 10 ? token.value : '%' + token.value
    default:
      return token.value
  }
}

function serialize (tokens) {
  return tokens.map(serializeToken).join('')
}

module.exports = {
  serialize: serialize
}
