module Context.Html exposing
    ( ContextHtml
    , a
    , abbr
    , address
    , applyContext
    , article
    , aside
    , audio
    , b
    , bdi
    , bdo
    , blockquote
    , br
    , button
    , canvas
    , caption
    , cite
    , code
    , col
    , colgroup
    , datalist
    , dd
    , del
    , details
    , dfn
    , div
    , dl
    , dt
    , em
    , embed
    , fieldset
    , figcaption
    , figure
    , footer
    , form
    , h1
    , h2
    , h3
    , h4
    , h5
    , h6
    , header
    , hr
    , i
    , iframe
    , img
    , input
    , ins
    , kbd
    , label
    , legend
    , li
    , main_
    , map
    , mark
    , math
    , menu
    , menuitem
    , meter
    , nav
    , node
    , object
    , ol
    , optgroup
    , option
    , output
    , p
    , param
    , pre
    , progress
    , q
    , rp
    , rt
    , ruby
    , s
    , samp
    , section
    , select
    , small
    , source
    , span
    , strong
    , sub
    , summary
    , sup
    , table
    , tbody
    , td
    , text
    , textarea
    , tfoot
    , th
    , thead
    , time
    , tr
    , track
    , u
    , ul
    , useContext
    , useContext2
    , useContext3
    , useContext4
    , useContext5
    , var
    , video
    , viewWithContext
    , wbr
    , withContext
    , wrapHtml
    )

{-| Context 有りの Html
Html.elm の代わりに使用する
-}

import Html exposing (Attribute, Html)


viewWithContext : (model -> ctx) -> (model -> ContextHtml ctx msg) -> model -> Html msg
viewWithContext modelToContext view model =
    applyContext (modelToContext model) (view model)


{-| Context を使用する
-}
useContext :
    (ctx -> a)
    -> (a -> ContextHtml ctx msg)
    -> ContextHtml ctx msg
useContext selector cb =
    withContext <|
        \ctx ->
            applyContext ctx <| cb (selector ctx)


useContext2 :
    (ctx -> a)
    -> (ctx -> b)
    -> (a -> b -> ContextHtml ctx msg)
    -> ContextHtml ctx msg
useContext2 selectorA selectorB cb =
    withContext <|
        \ctx ->
            applyContext ctx <| cb (selectorA ctx) (selectorB ctx)


useContext3 :
    (ctx -> a)
    -> (ctx -> b)
    -> (ctx -> c)
    -> (a -> b -> c -> ContextHtml ctx msg)
    -> ContextHtml ctx msg
useContext3 selectorA selectorB selectorC cb =
    withContext <|
        \ctx ->
            applyContext ctx <| cb (selectorA ctx) (selectorB ctx) (selectorC ctx)


useContext4 :
    (ctx -> a)
    -> (ctx -> b)
    -> (ctx -> c)
    -> (ctx -> d)
    -> (a -> b -> c -> d -> ContextHtml ctx msg)
    -> ContextHtml ctx msg
useContext4 selectorA selectorB selectorC selectorD cb =
    withContext <|
        \ctx ->
            applyContext ctx <| cb (selectorA ctx) (selectorB ctx) (selectorC ctx) (selectorD ctx)


useContext5 :
    (ctx -> a)
    -> (ctx -> b)
    -> (ctx -> c)
    -> (ctx -> d)
    -> (ctx -> e)
    -> (a -> b -> c -> d -> e -> ContextHtml ctx msg)
    -> ContextHtml ctx msg
useContext5 selectorA selectorB selectorC selectorD selectorE cb =
    withContext <|
        \ctx ->
            applyContext ctx <| cb (selectorA ctx) (selectorB ctx) (selectorC ctx) (selectorD ctx) (selectorE ctx)


type ContextHtml ctx msg
    = ContextHtml (ctx -> Html msg)


{-| Html を作成
-}
withContext : (ctx -> Html msg) -> ContextHtml ctx msg
withContext =
    ContextHtml


{-| Context を適用する
-}
applyContext : ctx -> ContextHtml ctx msg -> Html msg
applyContext ctx (ContextHtml view_) =
    view_ ctx


wrap :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (Attribute msg)
    -> List (ContextHtml ctx msg)
    -> ContextHtml ctx msg
wrap origin attr children =
    withContext <|
        \ctx ->
            origin attr (List.map (applyContext ctx) children)


{-| Html を ContextHtml に合わせる。
Svg などでも使えるように Expose している。
-}
wrapHtml : Html msg -> ContextHtml ctx msg
wrapHtml html =
    withContext <| \_ -> html



-- Html


node : String -> List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
node =
    Html.node >> wrap


text : String -> ContextHtml ctx msg
text =
    Html.text >> wrapHtml


map : (a -> msg) -> ContextHtml ctx a -> ContextHtml ctx msg
map f html =
    withContext
        (\ctx ->
            Html.map f (applyContext ctx html)
        )



-- SECTIONS


section : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
section =
    wrap Html.section


nav : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
nav =
    wrap Html.nav


article : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
article =
    wrap Html.article


aside : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
aside =
    wrap Html.aside


h1 : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
h1 =
    wrap Html.h1


h2 : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
h2 =
    wrap Html.h2


h3 : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
h3 =
    wrap Html.h3


h4 : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
h4 =
    wrap Html.h4


h5 : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
h5 =
    wrap Html.h5


h6 : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
h6 =
    wrap Html.h6


header : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
header =
    wrap Html.header


footer : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
footer =
    wrap Html.footer


address : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
address =
    wrap Html.address


main_ : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
main_ =
    wrap Html.main_



-- GROUPING CONTENT


p : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
p =
    wrap Html.p


hr : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
hr =
    wrap Html.hr


pre : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
pre =
    wrap Html.pre


blockquote : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
blockquote =
    wrap Html.blockquote


ol : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
ol =
    wrap Html.ol


ul : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
ul =
    wrap Html.ul


li : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
li =
    wrap Html.li


dl : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
dl =
    wrap Html.dl


dt : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
dt =
    wrap Html.dt


dd : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
dd =
    wrap Html.dd


figure : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
figure =
    wrap Html.figure


figcaption : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
figcaption =
    wrap Html.figcaption


div : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
div =
    wrap Html.div



-- TEXT LEVEL SEMANTIC


a : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
a =
    wrap Html.a


em : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
em =
    wrap Html.em


strong : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
strong =
    wrap Html.strong


small : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
small =
    wrap Html.small


s : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
s =
    wrap Html.s


cite : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
cite =
    wrap Html.cite


q : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
q =
    wrap Html.q


dfn : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
dfn =
    wrap Html.dfn


abbr : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
abbr =
    wrap Html.abbr


time : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
time =
    wrap Html.time


code : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
code =
    wrap Html.code


var : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
var =
    wrap Html.var


samp : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
samp =
    wrap Html.samp


kbd : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
kbd =
    wrap Html.kbd


sub : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
sub =
    wrap Html.sub


sup : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
sup =
    wrap Html.sup


i : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
i =
    wrap Html.i


b : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
b =
    wrap Html.b


u : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
u =
    wrap Html.u


mark : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
mark =
    wrap Html.mark


ruby : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
ruby =
    wrap Html.ruby


rt : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
rt =
    wrap Html.rt


rp : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
rp =
    wrap Html.rp


bdi : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
bdi =
    wrap Html.bdi


bdo : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
bdo =
    wrap Html.bdo


span : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
span =
    wrap Html.span


br : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
br =
    wrap Html.br


wbr : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
wbr =
    wrap Html.wbr



-- EDITS


ins : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
ins =
    wrap Html.ins


del : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
del =
    wrap Html.del



-- EMBEDDED CONTENT


img : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
img =
    wrap Html.img


iframe : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
iframe =
    wrap Html.iframe


embed : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
embed =
    wrap Html.embed


object : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
object =
    wrap Html.object


param : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
param =
    wrap Html.param


video : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
video =
    wrap Html.video


audio : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
audio =
    wrap Html.audio


source : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
source =
    wrap Html.source


track : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
track =
    wrap Html.track


canvas : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
canvas =
    wrap Html.canvas


math : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
math =
    wrap Html.math



-- TABULAR DATA


table : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
table =
    wrap Html.table


caption : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
caption =
    wrap Html.caption


colgroup : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
colgroup =
    wrap Html.colgroup


col : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
col =
    wrap Html.col


tbody : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
tbody =
    wrap Html.tbody


thead : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
thead =
    wrap Html.thead


tfoot : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
tfoot =
    wrap Html.tfoot


tr : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
tr =
    wrap Html.tr


td : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
td =
    wrap Html.td


th : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
th =
    wrap Html.th



-- FORMS


form : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
form =
    wrap Html.form


fieldset : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
fieldset =
    wrap Html.fieldset


legend : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
legend =
    wrap Html.legend


label : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
label =
    wrap Html.label


input : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
input =
    wrap Html.input


button : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
button =
    wrap Html.button


select : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
select =
    wrap Html.select


datalist : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
datalist =
    wrap Html.datalist


optgroup : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
optgroup =
    wrap Html.optgroup


option : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
option =
    wrap Html.option


textarea : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
textarea =
    wrap Html.textarea


output : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
output =
    wrap Html.output


progress : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
progress =
    wrap Html.progress


meter : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
meter =
    wrap Html.meter



-- INTERACTIVE ELEMENTS


details : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
details =
    wrap Html.details


summary : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
summary =
    wrap Html.summary


menuitem : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
menuitem =
    wrap Html.menuitem


menu : List (Attribute msg) -> List (ContextHtml ctx msg) -> ContextHtml ctx msg
menu =
    wrap Html.menu
