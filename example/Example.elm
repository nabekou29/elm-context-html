module Example exposing (main)

import Browser
-- Import `ContextHtml` instead of `Html`
import ContextHtml exposing (ContextHtml, button, div, text, useContext, viewWithContext)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = init
        , update = update
        -- Inject context
        , view = viewWithContext .context view
        }



-- MODEL


type alias Model =
    { text : String
    , context : Context
    }


type alias Context =
    { color : String
    }


init : Model
init =
    { text = "Hello, world"
    , context =
        { color = "white"
        }
    }



-- UPDATE


type Msg
    = ChangeColor String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeColor color ->
            let
                context =
                    model.context
            in
            { model | context = { context | color = color } }



-- VIEW


type alias HtmlWithContext msg =
    ContextHtml Context msg


view : Model -> HtmlWithContext Msg
view model =
    div []
        [ viewColorButtons, viewTextWrapper model.text ]


viewTextWrapper : String -> HtmlWithContext msg
viewTextWrapper str =
    viewText str


viewText : String -> HtmlWithContext msg
viewText str =
    -- Can use `color`, not an argument of the parent function
    useContext .color <|
        \color ->
            div
                [ style "background-color" color
                , style "height" "60px"
                , style "width" "60px"
                ]
                [ text str ]


viewColorButtons : HtmlWithContext Msg
viewColorButtons =
    div []
        ([ "red", "green", "yellow" ]
            |> List.map
                (\c ->
                    button
                        [ onClick <| ChangeColor c ]
                        [ text c ]
                )
        )
