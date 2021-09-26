module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Context exposing (HtmlWithContext, ViewContext, colorSelector, langSelector, useLang)
import Context.Html exposing (button, div, input, label, text, useContext, useContext2, viewWithContext)
import Html.Attributes exposing (checked, name, style, type_)
import Html.Events exposing (onClick, onInput)



-- MAIN


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = viewWithContext .context view
        }



-- MODEL


type alias Model =
    { count : Int
    , context : ViewContext
    }


init : Model
init =
    { count = 0
    , context =
        Context.new
            { color = Nothing
            , lang = Context.En
            }
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
        [ viewSelectLang
        , viewColorButtons
        , viewCurrentColor
        , button [ onClick Decrement ] [ text "-" ]
        , div [] [ viewCount model.count ]
        , button [ onClick Increment ] [ text "+" ]
        ]


viewCount : Int -> HtmlWithContext Msg
viewCount =
    --- 特に何も意識せずに Context を引き継げる
    viewCountInternal


viewCountInternal : Int -> HtmlWithContext Msg
viewCountInternal count =
    -- Context から必要な値を取り出して使用する
    useContext colorSelector <|
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
    -- 複数の値を取り出す
    useContext2 colorSelector langSelector <|
        \color lang ->
            case ( color, lang ) of
                ( Just color_, Context.Ja ) ->
                    div [] [ text ("現在: " ++ color_) ]

                ( Just color_, Context.En ) ->
                    div [] [ text ("Current: " ++ color_) ]

                ( Nothing, _ ) ->
                    div [] [ text "-" ]


viewSelectLang : HtmlWithContext Msg
viewSelectLang =
    -- よく使うものは関数切っても良さそう
    -- e.g. useLang
    useLang <|
        \lang ->
            div []
                [ label []
                    [ input
                        [ type_ "radio"
                        , name "lang"
                        , onInput <| \_ -> UpdateContext <| Context.ChangeLang Context.Ja
                        , checked <| lang == Context.Ja
                        ]
                        []
                    , text "Ja"
                    ]
                , label []
                    [ input
                        [ type_ "radio"
                        , name "lang"
                        , onInput <| \_ -> UpdateContext <| Context.ChangeLang Context.En
                        , checked <| lang == Context.En
                        ]
                        []
                    , text "En"
                    ]
                ]
