# # Laws for Monoids

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

# A value that implements the Monoid specification must also implement
# the Semigroup specification.

# ## The `empty` method

# A value which has a Monoid must provide an `empty` method on itself or
# its `constructor` object. The `empty` method takes no arguments:

#     m.empty()
#     m.constructor.empty()

# 1. `empty` must return a value of the same Monoid.


# ## 1st Law: right identity

# `m.concat(m.empty())` is equivalent to `m`

export right-identity = (f) ->
  for-all(Int).satisfy (a) ->
    m = f a
    return (m ++ m.empty!).is-equal m


# ## The 2nd Law: left identity

# `m.empty().concat(m)` is equivalent to `m`

export left-identity = (f) ->
  for-all(Int).satisfy (a) ->
    m = f a
    return (m.empty! ++ m).is-equal m
