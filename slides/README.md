# 資芽 C 班簡報模版 (xelatex)

## Installation

* 只需要跑一次，之後就可以直接編譯
* 可能會有點久，大概需要 2 GB 左右的空間

```bash
git clone git@github.com:tw-csie-sprout/c-template.git
cd c-template/slides
docker build -t . sproutc-xelatex
```

## Compile your tex file

```bash
docker run -v $(pwd):/output --rm sproutc-xelatex <檔案名稱>.tex
```

Example:

```bash
docker run -v $(pwd):/output --rm sproutc-xelatex example.tex
```

### Note

* 模版跟 `\begin{document}` 已經有包含在 docker image 裡面了，image 會用 `\input{}` 的方式把你的 tex file 引入
* tex file 的檔案位置沒有限制，想要在哪裡編譯就在哪裡編譯

P.S. 如果覺得指令太長可以寫一個 shell script 再設定 alias

### Compile Result

編譯結果有兩種：

* 編譯成功：當前資料夾會生成出 `<檔案名稱>.pdf` 跟 `log.txt` 兩個檔案
* 編譯失敗：可能會有 pdf，但是應該出了一點事，可以看 `log.txt` 檢查一下問題在哪裡

