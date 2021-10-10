module Main exposing (main)

-- Import `ContextHtml` instead of `Html`

import Browser
import Child
import ContextHtml exposing (ContextHtml, applyContext, button, div, input, text, useContext)
import ContextHtml.Lazy exposing (lazy)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = \( model, ctx ) -> applyContext ctx (view model)
        }



-- MODEL & CONTEXT


type alias Model =
    { text : String
    }


type alias Context =
    { color : Maybe String
    }


init : ( Model, Context )
init =
    ( { text = "Hello, world"
      }
    , { color = Nothing
      }
    )



-- UPDATE


type Msg
    = ChangeText String
    | ChangeColor String


update : Msg -> ( Model, Context ) -> ( Model, Context )
update msg ( model, context ) =
    case msg of
        ChangeText text ->
            ( { model | text = text }, context )

        ChangeColor color ->
            ( model, { context | color = Just color } )



-- VIEW


type alias HtmlWithContext msg =
    ContextHtml Context msg


view : Model -> HtmlWithContext Msg
view model =
    div []
        [ input [ onInput ChangeText, value model.text ] []
        , viewColorButtons
        , viewTextWrapper model.text
        ]


viewTextWrapper : String -> HtmlWithContext msg
viewTextWrapper str =
    div [] [ viewText str, viewChild ]


viewText : String -> HtmlWithContext msg
viewText str =
    -- Can use `color`, not an argument of the parent function
    useContext .color <|
        \color ->
            div
                [ style "background-color" (Maybe.withDefault "white" color)
                , style "padding" "12px"
                , style "display" "inline-block"
                ]
                [ text str ]


viewChild : HtmlWithContext msg
viewChild =
    useContext .color <|
        Maybe.map
            (\color ->
                -- Use ContextHtml.Lazy instead of Html.Lazy.
                lazy Child.view color
            )
            >> Maybe.withDefault (div [] [])


viewColorButtons : HtmlWithContext Msg
viewColorButtons =
    div []
        ([ "red", "green", "orange" ]
            |> List.map
                (\c ->
                    button
                        [ onClick <| ChangeColor c ]
                        [ text c ]
                )
        )
