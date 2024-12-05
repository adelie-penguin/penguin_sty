# penguin_sty

**latexによる原稿作成のためのスタイルファイル**  

main.texをコンパイルするためには下記のファイルを追加で用意する必要があります．
- sty/penguin.bst
- sty/jlisting.sty

文書作成にあたって編集が必要となるファイルは下記の2ファイルです．
- main.tex
- bibfile.bib

`make`コマンドを実行するとmain.pdfを生成します．
独自定義のコマンドの使い方はmain.pdfを参照してください．

<br><br><br>
ダウンロードコマンド
```
git clone --depth=1 https://github.com/adelie-penguin/penguin_sty/
```

<br><br><br>
同梱できなかったファイルの元ネタも提示しておきます．  
身内に配布したのは改造版ですが，リネームするだけでも問題ないかと思います．

|ファイル名|配布元|改造|
|----------|------|:----:|
|sty/penguin.bst |情報処理学会のテンプレート(ipsjunsrt.bst)|フィールドを追加|
|sty/jlisting.sty|http://teacher.nagano-nct.ac.jp/fujita/files/jlisting.sty|無|
