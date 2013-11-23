# # Laws for Monads

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

# A value that implements the Monad specification must also implement
# the Applicative and Chain specifications.

# A value that satisfies the specification of a Monad does not need to
# implement:

#  +  Applicative's `ap`; derivable as
#     `(m) => this.chain((f) => m.map(f))`

#  +  Functor's `map`; derivable as
#     `(f) => m = this, m.chain(a) => m.of(f(a))` 


# ## 1st Law: Left identity

# `m.of(a).chain(f)` is equivalent to `f(a)`

export left-identity = (f) ->
  M = f!
  for-all(Int) .satisfy (a) ->
    m = M.of a
    return m.chain((b) -> M.of b) .is-equal (M.of a)


# ## 2nd Law: Right identity

# `m.chain(m.of)` is equivalent to `m`

export right-identity = (f) ->
  M = f!
  for-all(Int) .satisfy (a) ->
    m = M.of a
    m.chain(M.of) .is-equal m
