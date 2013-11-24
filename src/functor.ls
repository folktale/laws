# # Laws for Functors

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

# ## The `map` method

# A value which has a Functor must provide a `map` method. The `map`
# method takes one argument.

#     u.map(f)

#  1. `f` must be a function,
#     1. If `f` is not a function, the behaviour of `map` is
#     unspecified.
#     2. `f` can return any value.
#  2. `map` must return a value of the same Functor.


# ## 1st Law: Identity

# `u.map((a) => a)` is equivalent to `u`

export identity = (f) ->
  for-all(Int).satisfy (a) ->
    ((f a).map (b) -> b).is-equal (f a)


# ## 2nd Law: Composition

# `u.map((a) -> f(g(a))` is equivalent to `u.map(f).map(g)`

export composition = (f) ->
  for-all(Int).satisfy (a) ->
    g = (* 2)
    h = (- 1)

    return ((f a).map (b) -> g (h b)).is-equal (f a).map(h).map(g)
