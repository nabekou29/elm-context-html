module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Context exposing (HtmlWithContext, ViewContext, bundle2, injectContext, useColor, useLang)
import ContextHtml exposing (button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = injectContext view }



-- MODEL


type alias Model =
    { count : Int
    , context : ViewContext
    }


init : Model
init =
    { count = 0
    , context = Context.new { color = Nothing, lang = Context.Ja }
    }



-- UPDATE


type Msg
    = Increment
    | Decrement
    | UpdateContext Context.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

        UpdateContext subMsg ->
            { model | context = Context.update subMsg model.context }



-- VIEW


view : Model -> HtmlWithContext Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ viewCount model.count ]
        , button [ onClick Increment ] [ text "+" ]
        , viewColorButtons
        , viewCurrentColor
        ]


viewCount : Int -> HtmlWithContext Msg
viewCount =
    viewCountInternal


viewCountInternal : Int -> HtmlWithContext Msg
viewCountInternal count =
    useColor <|
        \color ->
            div
                [ style "color" (Maybe.withDefault "black" color) ]
                [ text (String.fromInt count) ]


viewColorButtons : HtmlWithContext Msg
viewColorButtons =
    div []
        ([ "red", "blue", "yellow" ]
            |> List.map
                (\c ->
                    button
                        [ onClick <| UpdateContext (Context.ChangeColor c) ]
                        [ text c ]
                )
        )


viewCurrentColor : HtmlWithContext Msg
viewCurrentColor =
    bundle2 useColor useLang <|
        \color lang ->
            case ( color, lang ) of
                ( Just color_, Context.Ja ) ->
                    div [] [ text ("現在: " ++ color_) ]

                ( Just color_, Context.En ) ->
                    div [] [ text ("Current: " ++ color_) ]

                ( Nothing, _ ) ->
                    div [] [ text "-" ]
