# # Laws for Applicatives

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

# A value that implements the Applicative specification must also
# implement the Functor specification.

# A value which satisfies the specification does not need to implement:

#     Functor's `map`; derivable as `(f) => this.of(f).ap(this)`


# ## The `ap` method

# A value which has an Applicative must provide an `ap` method. The `ap`
# method takes one argument:

#     a.ap(b)

#  1. `a` must be an Applicative of a function,
#     1. If `a` does not represent a function, the behaviour of `ap` is
#        unspecified.
#  2. `b` must be an Applicative of any value.
#  3. `ap` must apply the function in Applicative `a` to the value in
#     Applicative `b`.


# ## The `of` method

# A value which has an Applicative must provide an `of` method on itself
# or its `constructor` object. The `of` method takes one argument.

#     a.of(b)
#     a.constructor.of(b)

#  1. `of` must provide a value of the same Appicative.
#     1. No parts of `b` should be checked.  
# 


# ## 1st Law: Identity

# `a.of((a) => a).ap(v)` is equivalent to `v`.

export identity = (f) ->
  A = f!
  for-all(Int).satisfy (a) ->
    (A.of (b) -> b).ap(A.of a).is-equal (A.of a)


# ## 2nd Law: Composition

# `a.of((f) => (g) => (x) => f(g(x))).ap(u).ap(v).ap(w)` is equivalent
# to `u.ap(v.ap(w))`

export composition = (f) ->
  A = f!
  for-all(Int).satisfy (a) ->
    g = (* 2)
    h = (- 1)
    x = (A.of (f) -> (g) -> (x) -> f (g x)).ap(A.of g).ap(A.of h).ap(A.of a)
    y = (A.of g).ap((A.of h).ap(A.of a))

    return x.is-equal y


# ## 3rd Law: Homomorphism

# `a.of(f).ap(a.of(x))` is equivalent to `a.of(f(x))`

export homomorphism = (f) ->
  A = f!
  for-all(Int).satisfy (a) ->
    g = (* 2)
    return (A.of g).ap(A.of a).is-equal (A.of (g a))


# ## 4th Law: Interchange

# `u.ap(a.of(y))` is equivalent to `a.of((f) => f(y)).ap(u)`

export interchange = (f) ->
  A = f!
  for-all(Int).satisfy (a) ->
    g = (* 2)
    return (A.of g).ap(A.of a).is-equal (A.of (f) -> f a).ap(A.of g)

