module Child exposing (view)

import ContextHtml exposing (ContextHtml, applyContext, button, div, text, useContext, wrapHtml)
import Html exposing (Html)
import Html.Attributes exposing (style)



-- CONTEXT


type alias ChildContext =
    { color : String
    }



-- VIEW


type alias HtmlWithContext msg =
    ContextHtml ChildContext msg


view : String -> ContextHtml ctx msg
view color =
    let
        context =
            { color = color
            }
    in
    wrapHtml <| applyContext context viewInternal


viewInternal : HtmlWithContext msg
viewInternal =
    viewInner "Child view"


viewInner : String -> HtmlWithContext msg
viewInner text_ =
    useContext .color <|
        \color ->
            div [ style "color" color ] [ text text_ ]


viewCommon : String -> Html msg
viewCommon str =
    Html.div [] [ Html.text str ]
