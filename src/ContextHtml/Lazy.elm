module ContextHtml.Lazy exposing (lazy, lazy2, lazy3, lazy4, lazy5, lazy6, lazy0)

{-| Wrapped [Html.Lazy](https://package.elm-lang.org/packages/elm/html/1.0.0/Html-Lazy) module for ContextHtml.

@docs lazy, lazy2, lazy3, lazy4, lazy5, lazy6, lazy0

-}

import ContextHtml exposing (ContextHtml, applyContext, withContext)
import Html.Lazy as Lazy


{-| Checks one argument and context.
-}
lazy :
    (a -> ContextHtml ctx msg)
    -> a
    -> ContextHtml ctx msg
lazy html a =
    withContext <|
        \ctx ->
            Lazy.lazy3 applyContextForLazy ctx html a


{-| Checks two arguments and context.
-}
lazy2 :
    (a -> b -> ContextHtml ctx msg)
    -> a
    -> b
    -> ContextHtml ctx msg
lazy2 html a b =
    withContext <|
        \ctx -> Lazy.lazy4 applyContextForLazy2 ctx html a b


{-| -}
lazy3 :
    (a -> b -> c -> ContextHtml ctx msg)
    -> a
    -> b
    -> c
    -> ContextHtml ctx msg
lazy3 html a b c =
    withContext <|
        \ctx -> Lazy.lazy5 applyContextForLazy3 ctx html a b c


{-| -}
lazy4 :
    (a -> b -> c -> d -> ContextHtml ctx msg)
    -> a
    -> b
    -> c
    -> d
    -> ContextHtml ctx msg
lazy4 html a b c d =
    withContext <|
        \ctx -> Lazy.lazy6 applyContextForLazy4 ctx html a b c d


{-| -}
lazy5 :
    (a -> b -> c -> d -> e -> ContextHtml ctx msg)
    -> a
    -> b
    -> c
    -> d
    -> e
    -> ContextHtml ctx msg
lazy5 html a b c d e =
    withContext <|
        \ctx -> Lazy.lazy7 applyContextForLazy5 ctx html a b c d e


{-| -}
lazy6 :
    (a -> b -> c -> d -> e -> f -> ContextHtml ctx msg)
    -> a
    -> b
    -> c
    -> d
    -> e
    -> f
    -> ContextHtml ctx msg
lazy6 html a b c d e f =
    withContext <|
        \ctx -> Lazy.lazy8 applyContextForLazy6 ctx html a b c d e f


{-| Checks only context.
-}
lazy0 :
    ContextHtml ctx msg
    -> ContextHtml ctx msg
lazy0 html =
    withContext <|
        \ctx ->
            Lazy.lazy2 applyContext ctx html


applyContextForLazy ctx html a =
    applyContext ctx (html a)


applyContextForLazy2 ctx html a b =
    applyContext ctx (html a b)


applyContextForLazy3 ctx html a b c =
    applyContext ctx (html a b c)


applyContextForLazy4 ctx html a b c d =
    applyContext ctx (html a b c d)


applyContextForLazy5 ctx html a b c d e =
    applyContext ctx (html a b c d e)


applyContextForLazy6 ctx html a b c d e f =
    applyContext ctx (html a b c d e f)
