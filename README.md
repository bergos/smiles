# smiles

OpenSMILES compatible parser and serializer

## Usage

    // load module
    var smiles = require('smiles')

    // parse a SMILES string, returns an array of SMILES tokens [{type: '...', value: '...'}, ...]
    var tokens = smiles.parse('IC(C=C1OC)=C(OC)C=C1CC(C)N')

    // serializes an array of SMILES tokens into a SMILES string
    var smilesString = smiles.serialize(tokens)
