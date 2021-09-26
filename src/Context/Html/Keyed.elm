module Context.Html.Keyed exposing (node, ol, ul)

import Context.Html exposing (ContextHtml, applyContext, withContext)
import Html exposing (Attribute)
import Html.Keyed as Keyed


node : String -> List (Attribute msg) -> List ( String, ContextHtml ctx msg ) -> ContextHtml ctx msg
node key attr children =
    withContext <|
        \ctx ->
            Keyed.node key attr (List.map (Tuple.mapSecond (applyContext ctx)) children)


ol : List (Attribute msg) -> List ( String, ContextHtml ctx msg ) -> ContextHtml ctx msg
ol =
    node "ol"


ul : List (Attribute msg) -> List ( String, ContextHtml ctx msg ) -> ContextHtml ctx msg
ul =
    node "ul"
