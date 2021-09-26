module ContextHtml exposing
    ( ContextHtml
    , applyContext
    , button
    , div
    , map
    , node
    , span
    , text
    , withContext
    , wrapHtml
    )

{-| Context 有りの Html
Html.elm の代わりに使用する
-}

import Html exposing (Attribute, Html)


type ContextHtml ctx msg
    = ContextHtml (ctx -> Html msg)


{-| ContextHtml を作成
-}
withContext : (ctx -> Html msg) -> ContextHtml ctx msg
withContext =
    ContextHtml


{-| Context を適用する
-}
applyContext : ctx -> ContextHtml ctx msg -> Html msg
applyContext ctx (ContextHtml view_) =
    view_ ctx



-- Html


wrap :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (ContextHtml ctx msg)
    -> ContextHtml ctx msg
wrap origin attr children =
    withContext <|
        \ctx ->
            origin attr (List.map (applyContext ctx) children)


{-| Html を ContextHtml に合わせる。
Svg などでも使えるように Expose している。
-}
wrapHtml : Html msg -> ContextHtml ctx msg
wrapHtml html =
    withContext <| \_ -> html


map : (a -> msg) -> ContextHtml ctx a -> ContextHtml ctx msg
map f html =
    withContext
        (\ctx ->
            Html.map f (applyContext ctx html)
        )


node : String -> List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
node =
    Html.node >> wrap


text : String -> ContextHtml ctx msg
text =
    Html.text >> wrapHtml



-- 以下は通常の Html 要素


div : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
div =
    wrap Html.div


span : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
span =
    wrap Html.span


button : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
button =
    wrap Html.button
