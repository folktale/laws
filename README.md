Laws
====

[![Build Status](https://secure.travis-ci.org/folktale/laws.png?branch=master)](https://travis-ci.org/folktale/laws)
[![NPM version](https://badge.fury.io/js/laws.png)](http://badge.fury.io/js/laws)
[![Dependencies Status](https://david-dm.org/folktale/laws.png)](https://david-dm.org/folktale/laws)
[![experimental](http://hughsk.github.io/stability-badges/dist/experimental.svg)](http://github.com/hughsk/stability-badges)


[Claire][] properties for verifying Monad and other algebraic structures' laws,
conforming to the [Fantasy Land][] specification.

To use this library, your algebraic structure needs to implement the `Eq`
typeclass, defined as:

```hs
class Eq a where
  isEqual :: a -> a -> Bool
```

Example:

```js
var Maybe = {
  /* (...) */
  isEqual: function(b) { 
    return this.isNothing?  b.isNothing
    :      this.isJust?     this.value === b.value
  }
  /* (...) */
}
```

[Claire]: https://github.com/hifivejs/claire
[Fantasy Land]: https://github.com/fantasyland/fantasy-land


## Example

```js
var Maybe = require('monads.maybe')
var laws  = require('laws')

laws.functors.identity(Maybe.Just).asTest({ verbose: true, times: 100 })()
// + OK passed 100 tests.
```


## Installing

The easiest way is to grab it from NPM:

    $ npm install laws
    
    
## Documentation

( TBD )


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :)

[es5-shim]: https://github.com/kriskowal/es5-shim


## Licence

Copyright (c) 2013 Quildreen Motta.

Released under the [MIT licence](https://github.com/folktale/monads.maybe/blob/master/LICENCE).

