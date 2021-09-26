module Context exposing
    ( ContextData
    , HtmlWithContext
    , Lang(..)
    , Msg(..)
    , ViewContext
    , bundle2
    , bundle3
    , bundle4
    , injectContext
    , new
    , update
    , useColor
    , useLang
    )

import ContextHtml exposing (ContextHtml, applyContext, withContext)
import Html exposing (Attribute, Html)


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


update : Msg -> ViewContext -> ViewContext
update msg (ViewContext data) =
    ViewContext <|
        case msg of
            ChangeColor color ->
                { data | color = Just color }



-- View


type alias WitchContext model =
    { model | context : ViewContext }


injectContext : (WitchContext model -> HtmlWithContext msg) -> WitchContext model -> Html msg
injectContext view model =
    applyContext model.context (view model)



-- Use
-- 使用する情報がわかりやすいようにって感じで切ったけど、使い勝手悪いかも


useContext : (ViewContext -> HtmlWithContext msg) -> HtmlWithContext msg
useContext cb =
    withContext <|
        \ctx ->
            applyContext ctx (cb ctx)


useColor : (Maybe String -> HtmlWithContext msg) -> HtmlWithContext msg
useColor cb =
    useContext <|
        \(ViewContext { color }) ->
            cb color


useLang : (Lang -> HtmlWithContext msg) -> HtmlWithContext msg
useLang cb =
    useContext <|
        \(ViewContext { lang }) ->
            cb lang



-- Bundle
-- useXXX をまとめて使用できるようにする


bundle2 :
    ((a -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> ((b -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> (a -> b -> HtmlWithContext msg)
    -> HtmlWithContext msg
bundle2 useA useB cb =
    useA (\a -> useB (\b -> cb a b))


bundle3 :
    ((a -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> ((b -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> ((c -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> (a -> b -> c -> HtmlWithContext msg)
    -> HtmlWithContext msg
bundle3 useA useB useC cb =
    bundle2 useA useB <| \a b -> useC (\c -> cb a b c)


bundle4 :
    ((a -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> ((b -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> ((c -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> ((d -> HtmlWithContext msg) -> HtmlWithContext msg)
    -> (a -> b -> c -> d -> HtmlWithContext msg)
    -> HtmlWithContext msg
bundle4 useA useB useC useD cb =
    bundle3 useA useB useC <| \a b c -> useD (\d -> cb a b c d)
