module ContextHtml.Lazy exposing (lazy, lazy2, lazy3, lazy4, lazy5, lazy6, lazy7, lazy8)

{-| Wrapped [Html.lazy](https://package.elm-lang.org/packages/elm/html/1.0.0/Html-Lazy) module for ContextHtml.

@docs lazy, lazy2, lazy3, lazy4, lazy5, lazy6, lazy7, lazy8

-}

import ContextHtml exposing (ContextHtml, applyContext, withContext)
import Html.Lazy as Lazy


{-| -}
lazy : (a -> ContextHtml ctx msg) -> a -> ContextHtml ctx msg
lazy html a =
    withContext <|
        \ctx ->
            Lazy.lazy (\a_ -> applyContext ctx (html a_)) a


{-| -}
lazy2 : (a -> b -> ContextHtml ctx msg) -> a -> b -> ContextHtml ctx msg
lazy2 html a b =
    withContext <|
        \ctx -> Lazy.lazy2 (\a_ b_ -> applyContext ctx (html a_ b_)) a b


{-| -}
lazy3 : (a -> b -> c -> ContextHtml ctx msg) -> a -> b -> c -> ContextHtml ctx msg
lazy3 html a b c =
    withContext <|
        \ctx -> Lazy.lazy3 (\a_ b_ c_ -> applyContext ctx (html a_ b_ c_)) a b c


{-| -}
lazy4 : (a -> b -> c -> d -> ContextHtml ctx msg) -> a -> b -> c -> d -> ContextHtml ctx msg
lazy4 html a b c d =
    withContext <|
        \ctx -> Lazy.lazy4 (\a_ b_ c_ d_ -> applyContext ctx (html a_ b_ c_ d_)) a b c d


{-| -}
lazy5 : (a -> b -> c -> d -> e -> ContextHtml ctx msg) -> a -> b -> c -> d -> e -> ContextHtml ctx msg
lazy5 html a b c d e =
    withContext <|
        \ctx -> Lazy.lazy5 (\a_ b_ c_ d_ e_ -> applyContext ctx (html a_ b_ c_ d_ e_)) a b c d e


{-| -}
lazy6 : (a -> b -> c -> d -> e -> f -> ContextHtml ctx msg) -> a -> b -> c -> d -> e -> f -> ContextHtml ctx msg
lazy6 html a b c d e f =
    withContext <|
        \ctx -> Lazy.lazy6 (\a_ b_ c_ d_ e_ f_ -> applyContext ctx (html a_ b_ c_ d_ e_ f_)) a b c d e f


{-| -}
lazy7 : (a -> b -> c -> d -> e -> f -> g -> ContextHtml ctx msg) -> a -> b -> c -> d -> e -> f -> g -> ContextHtml ctx msg
lazy7 html a b c d e f g =
    withContext <|
        \ctx -> Lazy.lazy7 (\a_ b_ c_ d_ e_ f_ g_ -> applyContext ctx (html a_ b_ c_ d_ e_ f_ g_)) a b c d e f g


{-| -}
lazy8 : (a -> b -> c -> d -> e -> f -> g -> h -> ContextHtml ctx msg) -> a -> b -> c -> d -> e -> f -> g -> h -> ContextHtml ctx msg
lazy8 html a b c d e f g h =
    withContext <|
        \ctx -> Lazy.lazy8 (\a_ b_ c_ d_ e_ f_ g_ h_ -> applyContext ctx (html a_ b_ c_ d_ e_ f_ g_ h_)) a b c d e f g h
