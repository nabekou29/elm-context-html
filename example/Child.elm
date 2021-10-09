module Child exposing (view)

import ContextHtml exposing (ContextHtml, applyContext, div, useContext, wrapHtml)
import ContextHtml.Lazy exposing (lazy)
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
    -- Use wrapHtml and applyContext to switch Context
    wrapHtml <| applyContext context viewInternal


viewInternal : HtmlWithContext msg
viewInternal =
    lazy viewInner "Child view"


viewInner : String -> HtmlWithContext msg
viewInner text_ =
    useContext .color <|
        \color ->
            div [ style "color" color ]
                -- View functions that return `Html msg` need to be wrapped.
                [ wrapHtml <| viewCommon text_
                ]


viewCommon : String -> Html msg
viewCommon str =
    Html.div [] [ Html.text str ]
