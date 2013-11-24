# # Laws for Chain

/** ^
 * Copyright (c) 2013 Quildreen "Sorella" Motta <quildreen@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation files
 * (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


{ for-all, data: { Int } } = require 'claire'

# ## The `chain` method

# A value which has a Chain must provide a `chain` method. The `chain`
# method takes one argument.

#     m.chain(f)

#  1. `f` must be a function which returns a value
#     1. If `f` is not a function, the behaviour of `chain` is
#        unspecified.
#     2. `f` must return a value of the same Chain.
#  2. `chain` must return a value of the same Chain.


# ## 1st Law: Associativity

# `m.chain(f).chain(g)` is equivalent to `m.chain((x) => f(x).chain(g))`

export associativity = (f) ->
  for-all(Int).satisfy (a) ->
    g = (a) -> f (a * 2)
    h = (a) -> f (a - 1)

    return (f a).chain(g).chain(h).is-equal (f a).chain (x) -> g(x).chain h
