# elm-context-html

It works like elm/html, and the context can be used anywhere.

## Before

```elm
view : Model -> Html Msg
view model =
    let
        contextValue = ...
    in
    viewChild1 contextValue 

viewChild1 contextValue =
    -- `contextValue` is not used in this View, 
    -- but is received and through for use in descendant View.
    viewChild2 contextValue
    
viewChild2 contextValue =
    viewChild3 contextValue

...

viewChildN contextValue =
    div [] [ text contextValue ]
```

## After (Use ContextHtml)

```elm
import ContextHtml exposing (..)

type alias Context =
    { contextValue : String
    }
    
view : Model -> ContextHtml Context Msg
view model =
    viewChild1 

viewChild1 =
    viewChild2
    
viewChild2 =
    viewChild3

...

viewChildN =  
    -- Take out the value as needed.
    useContext .contextValue <| 
        \contextValue -> div [] [ text contextValue ]

```

# Usage

Refer to `Example.elm` for details.

## Define views using context

HTML tags defined in ContextHtml returns `ContextHtml ctx msg`.

```elm
-- Import `ContextHtml` instead of `Html`
import ContextHtml exposing (..)
import Html.Attributes exposing (..)

view : Model -> HtmlWithContext Msg
view model =
    div [] [ text "Text" ]
        
type alias HtmlWithContext msg =
    ContextHtml Context msg
    
type alias Context =
    { contextValue : String
    }
```

To use a value of Context, use `useContext`.  
`useContext2`, `useContext3`, etc. are available for using multiple values.

```elm
viewWithContext : HtmlWithContext Msg
viewWithContext =
    useContext .contextValue <|
        \v -> div []  [ text v ]
```

## Apply context to views

```elm
import Browser

main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view = \( model, ctx ) -> applyContext ctx (view model)
        }
        
init : ( Model, Context )
init = ...

update : Msg -> ( Model, Context ) -> ( Model, Context )
update msg ( model, context ) = ...

view : Model -> ContextHtml Context Msg
view model = ...
```
