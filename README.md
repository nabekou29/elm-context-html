# elm-context-pattern

いろんな view 関数で使う値をいい感じに引き回すためのやつ。

## 各ファイル

```sh
src/
├── Context.elm
├── ContextHtml.elm
└── Main.elm
```

### Main.elm

メインの Model, Msg, Update, View など。

### Context.elm

アプリの Context の定義と、それを更新・使用するための関数を定義。

### ContextHtml.elm

**通常の Html** を **Context 有り Html** に置き換えるためのモジュール。

メインは Html.elm の関数の代わりに使用する関数。
そのほか Context 有り Html を生成する関数や Context を適用する関数などが含まれる。 