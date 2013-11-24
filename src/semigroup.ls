# # Laws for Semigroups

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

# ## The `concat` method

# A value which has a Semigroup must provide a `concat` method. The
# `concat` method takes one argument:

#     s.concat(b)

#  1. `b` must be a value of the same Semigroup.
#     i. if `b` is not of the same Semigroup, behaviour of `concat` is
#     unspecified.
#  2. `concat` must return a value of the same Semigroup.


# ## 1st Law: Associativity

# `a.concat(b).concat(c)` is equivalent to `a.concat(b.concat(c))`.

export associativity = (f) ->
  for-all(Int, Int, Int).satisfy (a, b, c) ->
    x = (f a).concat(f b).concat(f c)
    y = (f a).concat((f b).concat(f c))

    x.is-equal y
