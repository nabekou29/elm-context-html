# elm-context-html

It works like elm/html, and the context can be used anywhere.

# Usage

Refer to `Example.elm` for details.

## Import

Import `ContextHtml` instead of `Html`.

```elm
import ContextHtml exposing (..)
import ContextHtml.Lazy exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
```

## Model

Define Context as part of Model.

```elm
type alias Model =
    { hoge : Hoge
    , context : Context
    }

type alias Context =
    { contextValue : Value
    }
```

## Update

Update Model and Context.

## View with Context

HTML tags defined in ContextHtml returns `ContextHtml ctx msg`.

```elm
view : Model -> HtmlWithContext Msg
view model =
    div [] [ viewHoge model ]
        
-- It is useful to define an alias.
type alias HtmlWithContext msg =
    ContextHtml Context msg
```

To use a value of Context, use `useContext`.
For handling multiple values, `useContext2`, `useContext3`, etc. are provided.

```elm
viewWithContext : HtmlWithContext Msg
viewWithContext =
    -- Context has a contextValue
    useContext .contextValue <|
        \v -> div []  [text v ]
```

### Inject context to view

```elm
main =
    Browser.sandbox
        { init = init
        , update = update
        -- Inject context
        , view = viewWithContext .context view
        }
```