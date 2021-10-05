module Main exposing (main)

-- Import `ContextHtml` instead of `Html`

import Child
import ContextHtml exposing (ContextHtml, applyContext, button, div, text, useContext)
import ContextHtml.Browser as Browser
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
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
    = ChangeColor String


update : Msg -> Model -> Context -> ( Model, Context )
update msg model context =
    case msg of
        ChangeColor color ->
            ( model, { context | color = Just color } )



-- VIEW


type alias HtmlWithContext msg =
    ContextHtml Context msg


view : Model -> HtmlWithContext Msg
view model =
    div []
        [ viewColorButtons, viewTextWrapper model.text ]


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
                , style "height" "60px"
                , style "width" "60px"
                ]
                [ text str ]


viewChild : HtmlWithContext msg
viewChild =
    useContext .color <|
        Maybe.map
            (\color ->
                Child.view color
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


a : Int -> String -> Bool
a =
    Debug.todo ""


b : Bool -> Float
b =
    Debug.todo ""


c : unknown
c =
    a >> b
