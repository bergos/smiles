{

  function flat (input) {
    if (Array.isArray(input)) {
      var result = []

      input.forEach(function (item) {
        if (!item) {
          return
        }

        if (Array.isArray(item)) {
           result = result.concat(flat(item))
        } else {
           result.push(item)
        }
      })

      return result
    } else {
      return input
    }
  }

  var chiralMap = {
    '@': 'anticlockwise',
    '@@': 'clockwise'
  }

}

start
  = Smiles

Atom
  = value:BracketAtom { return flat(value) }
  / AliphaticOrganic
  / AromaticOrganic
  / '*'

AliphaticOrganic
  = value:AliphaticOrganicValue {
    return {type: 'AliphaticOrganic', value: value}
  }

AliphaticOrganicValue
  = 'Br' / 'B' / 'Cl' / 'C' / 'N' / 'O' / 'S' / 'P' / 'F' / 'I'

AromaticOrganic
  = value:AromaticOrganicValue {
    return {type: 'AromaticOrganic', value: value}
  }

AromaticOrganicValue
  = 'b' / 'c' / 'n' / 'o' / 's' / 'p'

BracketAtom
   = BracketAtomBegin Isotope? Symbol Chiral? HydrogenCount? Charge? Class? BracketAtomEnd

BracketAtomBegin
  = '[' {
    return {type: 'BracketAtom', value: 'begin'}
  }

BracketAtomEnd
  = ']' {
    return {type: 'BracketAtom', value: 'end'}
  }

Symbol
  = ElementSymbol
  / AromaticSymbol
  / '*'

Isotope
  = value:NUMBER {
    return value ? {type: 'Isotope', value: value} : null
  }

ElementSymbol
  = value:ElementSymbolValue {
    return {type: 'ElementSymbol', value: value}
  }

ElementSymbolValue
  = 'Ac' / 'Ag' / 'Al' / 'Am' / 'Ar' / 'As' / 'At' / 'Au'
  / 'Ba' / 'Be' / 'Bh' / 'Bi' / 'Bk' / 'Br' / 'B'
  / 'Ca' / 'Cd' / 'Ce' / 'Cf' / 'Cl' / 'Cm' / 'Cn' / 'Co' / 'Cr' / 'Cs' / 'Cu' / 'C'
  / 'Db' / 'Ds' / 'Dy'
  / 'Er' / 'Es' / 'Eu'
  / 'Fe' / 'Fl' / 'Fm' / 'Fr' / 'F'
  / 'Ga' / 'Gd' / 'Ge'
  / 'He' / 'Hf' / 'Hg' / 'Ho' / 'Hs' / 'H'
  / 'In' / 'Ir' / 'I'
  / 'Kr' / 'K'
  / 'La' / 'Li' / 'Lr' / 'Lu' / 'Lv'
  / 'Md' / 'Mg' / 'Mn' / 'Mo' / 'Mt'
  / 'Na' / 'Nb' / 'Nd' / 'Ne' / 'Ni' / 'No' / 'Np' / 'N'
  / 'Os' / 'O'
  / 'Pa' / 'Pb' / 'Pd' / 'Pm' / 'Po' / 'Pr' / 'Pt' / 'Pu' / 'P'
  / 'Ra' / 'Rb' / 'Re' / 'Rf' / 'Rg' / 'Rh' / 'Rn' / 'Ru'
  / 'Sb' / 'Sc' / 'Se' / 'Sg' / 'Si' / 'Sm' / 'Sn' / 'Sr' / 'S'
  / 'Ta' / 'Tb' / 'Tc' / 'Te' / 'Th' / 'Ti' / 'Tl' / 'Tm'
  / 'U'
  / 'V'
  / 'W'
  / 'Xe'
  / 'Yb' / 'Y'
  / 'Zn' / 'Zr'

AromaticSymbol
  = value:AromaticSymbolsValue {
    return {type: 'AromaticSymbol', value: value}
  }

AromaticSymbolsValue
  = 'as'
  / 'b'
  / 'c'
  / 'n'
  / 'o'
  / 'p'
  / 'se' / 's'

Chiral
  = value:ChiralValue {
    return {type: 'Chiral', value: chiralMap[value]}
  }

ChiralValue
  = '@@'
  / '@'

HydrogenCount
  = 'H' value:DIGIT? {
    return {type: 'HydrogenCount', value: value !== null ? value : 1}
  }

Charge
  = '-' value:NUMBER? {
    return {type: 'Charge', value: value ? value * -1 : -1}
  }
  / '+' value:NUMBER? {
    return {type: 'Charge', value: value ? value: 1}
  }

Class
  = ':' value:NUMBER {
    return {type: 'Class', value: value}
  }

Bond
  = value:BondValue {
    return {type: 'Bond', value: value}
  }

BondValue
  = '-' / '=' / '#' / '$' / ':' / '/' / '\\'

Ringbond
  = bond:Bond? value:DIGIT {
    return [bond, {type: 'Ringbond', value: value}]
  }
  / bond:Bond? '%' value:NUMBER {
    return [bond, {type: 'Ringbond', value: value}]
  }

BranchedAtom
  = Atom Ringbond* Branch*

Branch
  = BranchBegin Chain* BranchEnd

BranchBegin
  = '(' {
    return {type: 'Branch', value: 'begin'}
  }

BranchEnd
  = ')' {
    return {type: 'Branch', value: 'end'}
  }

Chain
  = BranchedAtom
  / Bond BranchedAtom
  / Dot BranchedAtom

Dot
  = '.'{
    return {type: 'Bond', value: '.'}
  }

Smiles
  = Chain:Chain* {
    return flat(Chain)
  }

DIGIT
  = [0-9] {
    return parseInt(text())
  }

NUMBER
  = [0-9]+ {
    return parseInt(text())
  }
