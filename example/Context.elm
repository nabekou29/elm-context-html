module Context exposing
    ( ContextData
    , HtmlWithContext
    , Lang(..)
    , Msg(..)
    , ViewContext
    , colorSelector
    , langSelector
    , new
    , update
    , useLang
    )

import Context.Html exposing (ContextHtml, useContext)


type alias HtmlWithContext msg =
    ContextHtml ViewContext msg


type ViewContext
    = ViewContext ContextData


type alias ContextData =
    { color : Maybe String
    , lang : Lang
    }


new : ContextData -> ViewContext
new =
    ViewContext


type Lang
    = Ja
    | En



-- Update


type Msg
    = ChangeColor String
    | ChangeLang Lang


update : Msg -> ViewContext -> ViewContext
update msg (ViewContext data) =
    ViewContext <|
        case msg of
            ChangeColor color ->
                { data | color = Just color }

            ChangeLang lang ->
                { data | lang = lang }



-- Selector


colorSelector : ViewContext -> Maybe String
colorSelector (ViewContext { color }) =
    color


langSelector : ViewContext -> Lang
langSelector (ViewContext { lang }) =
    lang



-- Use


useLang : (Lang -> ContextHtml ViewContext msg) -> ContextHtml ViewContext msg
useLang =
    useContext langSelector
