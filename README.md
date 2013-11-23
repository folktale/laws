Laws
====

[![Build Status](https://secure.travis-ci.org/folktale/laws.png?branch=master)](https://travis-ci.org/folktale/laws)
[![NPM version](https://badge.fury.io/js/laws.png)](http://badge.fury.io/js/laws)
[![Dependencies Status](https://david-dm.org/folktale/laws.png)](https://david-dm.org/folktale/laws)
[![experimental](http://hughsk.github.io/stability-badges/dist/experimental.svg)](http://github.com/hughsk/stability-badges)


[Claire][] properties for verifying Monad and other algebraic structures' laws,
conforming to the [Fantasy Land][] specification.


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

The easiest way is to grab it from NPM. If you're running in a Browser
environment, you can use [Browserify][]

    $ npm install laws

[Browserify]: http://browserify.org/


### Using with CommonJS

If you're not using NPM, [Download the latest release][release], and require
the `folktale.laws.umd.js` file:

```js
var laws = require('laws')
```

[release]: https://github.com/folktale/laws/releases/download/v0.2.0/laws-0.2.0.tar.gz


### Using with AMD

[Download the latest release][release], and require the `folktale.laws.umd.js`
file:

```js
require(['folktale.laws'], function(laws) {
  ...
})
```


### Using without modules

[Download the latest release][release], and load the `folktale.laws.umd.js`
file. The properties are exposed in the global `Laws` object:

```html
<script src="/path/to/folktale.laws.umd.js"></script>
```


### Compiling from source

If you want to compile this library from the source, you'll need [Git][],
[Make][], [Node.js][], and run the following commands:

    $ git clone git://github.com/folktale/laws.git
    $ cd laws
    $ npm install
    $ make bundle
    
This will generate the `dist/folktale.laws.umd.js` file, which you can load in
any JavaScript environment.
    
[Git]: http://git-scm.com/
[Make]: http://www.gnu.org/software/make/
[Node.js]: http://nodejs.org/
    
    
## Getting Started

This library provides properties for verifying the correctness of an
implementation of algebraic structures according to the [Fantasy Land][]
specification. They do so by generating random inputs and checking if the
algebraic laws holds for your structure.

In order to use these properties, your algebraic library needs to implement the
`Eq` typeclass, defined as:

```hs
class Eq a where
  -- | True if both structures are equivalent
  isEqual :: a -> a -> Bool
```

Here's an example of such implementation, for a `Maybe(a)` monad:

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


### The Laws

 *  Applicatives
    1. Identity
    2. Composition
    3. Homomorphism
    4. Interchange
 *  Chains
    1. Associativity
 *  Functors
    1. Identity
    2. Composition
 *  Monads
    1. Left identity
    2. Right identity
 *  Monoids
    1. Left identity
    2. Right identity
 *  Semigroups
    1. Associativity
    
    
### Using the laws

To verify if a data structure conforms to the laws, you need to partially apply
the law to a function that constructs a structure holding a single value. For
example, if you have an `Identity` container and want to check if it conforms
to the Semigroup's law of associativity:

```js
// :: a -> Id a
function makeId(a) {
  return new Id(a)
}

laws.semigroup.associativity(makeId).asTest({ verbose: true })()
// + OK passed 100 tests
```

Note that applying the law to the constructor function gives you back a
[Claire][] property. There are different ways of using this object, but the
easiest one is to use the `asTest(configuration)` method to return a test
function. When invoked (with no parameters), this test function will repeatedly
generate random inputs to test if your implementation behaves correctly
according to the laws.

If any of the inputs invalidates the property, an error is thrown with detailed
information about why the property was invalidated. You can control both the
amount of details in the reports, and the number of random tests that are
performed by passing a configuration object to the `asTest` method. By default
the reports are concise and only 100 random tests are performed.

```hs
class Configuration where
  verbose :: Bool       -- * whether to output a detailed report or not
  times   :: Int        -- * number of random tests to perform
```

Do note that if `verbose` is false, no message will be printed to the standard
output by default.


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :)

[es5-shim]: https://github.com/kriskowal/es5-shim


## Licence

Copyright (c) 2013 Quildreen Motta.

Released under the [MIT licence](https://github.com/folktale/monads.maybe/blob/master/LICENCE).

