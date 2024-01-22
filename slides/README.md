# 資芽 C 班簡報模版 (xelatex)

## Installation

* 只需要跑一次，之後就可以直接編譯 (step 3)
* 可能會有點久，大概需要 2 GB 左右的空間

```
git clone git@github.com:tw-csie-sprout/c-template.git
cd c-template/slides
docker build -t . sproutc-xelatex
```

## 編譯 tex file

* tex file 的檔案位置沒有限制，想要在哪裡編譯就在哪裡編譯

```
docker run -v $(pwd):/output --rm sproutc-xelatex <檔案名稱>.tex
```

舉例來說：

```
docker run -v $(pwd):/output --rm sproutc-xelatex example.tex
```

P.S. 如果覺得太長可以寫一個 shell script 再設定 alias

* 編譯結果有兩種：
    * 編譯成功：當前資料夾會生成出 `<檔案名稱>.pdf` 跟 `log.txt` 兩個檔案
    * 編譯失敗：可能會有 pdf，但是應該出了一點事，可以看 `log.txt` 檢查一下問題在哪裡

