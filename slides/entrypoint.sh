#!/bin/bash

# Check if the filename is provided as an argument
if [ -z "$1" ]; then
    echo "Error: Please provide the filename as an argument."
    exit 1
fi

# Run xelatex on the specified LaTeX file
base=$(basename "$1" .tex)

# Copy every file to /temp directory
cp -r "/output" "/temp"

# Create template.tex for compiling
cp /template.tex "/temp/template.tex"
echo -e '\\begin{document}\n\t\\input{'"/temp/$1"'}\n\\end{document}' >> "/temp/template.tex"


echo -e "\nCompiling $1 ..."

# Compile twice is necessary for ToC
cd /temp
xelatex -shell-escape -synctex=1 -interaction=nonstopmode "/temp/template.tex" > /dev/null
xelatex -shell-escape -synctex=1 -interaction=nonstopmode "/temp/template.tex" > /dev/null

# Change the name back to base.pdf, and copy output and log.txt to user folder
mv "/temp/template.pdf" "/temp/$base.pdf"
cp "/temp/$base.pdf" "/output/"
cp /temp/template.log "/output/$base.log"


if [ $? -eq 0 ]; then
    echo "Command was successful."
    echo "Feel free to check $base.log for logs."
else
    echo "Command failed with an error"
    echo "Please check log.txt for more details."
fi
