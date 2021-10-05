module ContextHtml.Browser exposing
    ( application
    , document
    , element
    , sandbox
    )

{-| -}

import Browser
import Browser.Navigation as Navigation
import ContextHtml exposing (ContextHtml, applyContext)
import Html exposing (Html)
import Url


type alias Model model ctx =
    { model : model
    , ctx : ctx
    }


type alias Document ctx msg =
    { title : String
    , body : List (ContextHtml ctx msg)
    }


sandbox :
    { init : ( model, ctx )
    , view : model -> ContextHtml ctx msg
    , update : msg -> model -> ctx -> ( model, ctx )
    }
    -> Program () (Model model ctx) msg
sandbox conf =
    Browser.sandbox
        { init = conf.init |> (\( model_, ctx_ ) -> Model model_ ctx_)
        , view = viewWithContext conf.view
        , update =
            \msg { model, ctx } ->
                conf.update msg model ctx |> (\( model_, ctx_ ) -> Model model_ ctx_)
        }


element :
    { init : flags -> ( model, ctx, Cmd msg )
    , view : model -> ContextHtml ctx msg
    , update : msg -> model -> ctx -> ( model, ctx, Cmd msg )
    , subscriptions : Model model ctx -> Sub msg
    }
    -> Program flags (Model model ctx) msg
element conf =
    Browser.element
        { init = initWithContext conf.init
        , view = viewWithContext conf.view
        , update = updateWithContext conf.update
        , subscriptions = conf.subscriptions
        }


document :
    { init : flags -> ( model, ctx, Cmd msg )
    , view : model -> Document ctx msg
    , update : msg -> model -> ctx -> ( model, ctx, Cmd msg )
    , subscriptions : Model model ctx -> Sub msg
    }
    -> Program flags (Model model ctx) msg
document conf =
    Browser.document
        { init = initWithContext conf.init
        , view = viewDocumentWithContext conf.view
        , update = updateWithContext conf.update
        , subscriptions = conf.subscriptions
        }


application :
    { init : flags -> Url.Url -> Navigation.Key -> ( model, ctx, Cmd msg )
    , view : model -> Document ctx msg
    , update : msg -> model -> ctx -> ( model, ctx, Cmd msg )
    , subscriptions : Model model ctx -> Sub msg
    , onUrlRequest : Browser.UrlRequest -> msg
    , onUrlChange : Url.Url -> msg
    }
    -> Program flags (Model model ctx) msg
application conf =
    Browser.application
        { init = initWithContextForApplication conf.init
        , view = viewDocumentWithContext conf.view
        , update = updateWithContext conf.update
        , subscriptions = conf.subscriptions
        , onUrlRequest = conf.onUrlRequest
        , onUrlChange = conf.onUrlChange
        }


initWithContext : (flags -> ( model, ctx, Cmd a )) -> flags -> ( Model model ctx, Cmd a )
initWithContext func =
    func >> (\( model_, ctx_, cmd ) -> ( Model model_ ctx_, cmd ))


initWithContextForApplication :
    (flags -> Url.Url -> Navigation.Key -> ( model, ctx, Cmd a ))
    -> flags
    -> Url.Url
    -> Navigation.Key
    -> ( Model model ctx, Cmd a )
initWithContextForApplication func url nav =
    func url nav >> (\( model_, ctx_, cmd ) -> ( Model model_ ctx_, cmd ))


updateWithContext :
    (msg -> model -> ctx -> ( model, ctx, Cmd msg ))
    -> msg
    -> Model model ctx
    -> ( Model model ctx, Cmd msg )
updateWithContext func msg { model, ctx } =
    func msg model ctx |> (\( model_, ctx_, cmd ) -> ( Model model_ ctx_, cmd ))


viewWithContext : (model -> ContextHtml ctx msg) -> Model model ctx -> Html msg
viewWithContext func { model, ctx } =
    applyContext ctx (func model)


viewDocumentWithContext : (model -> Document ctx msg) -> Model model ctx -> Browser.Document msg
viewDocumentWithContext func { model, ctx } =
    func model
        |> (\{ title, body } ->
                { title = title
                , body = List.map (applyContext ctx) body
                }
           )
