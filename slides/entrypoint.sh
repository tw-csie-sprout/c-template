#!/bin/bash

# Check if the filename is provided as an argument
if [ -z "$1" ]; then
    echo "Error: Please provide the filename as an argument."
    exit 1
fi

# Run xelatex on the specified LaTeX file
base=$(basename "$1" .tex)
newname="$base""_$(cat /dev/urandom | head -c 4 | base64).tex"
cp "/output/$1" "/$newname"
mv /template.tex "/$1"
echo -e '\\begin{document}\n\t\\input{'"/$newname"'}\n\\end{document}' >> "/$1"
cd /output

# Compile twice is necessary for ToC
xelatex -synctex=1 -interaction=nonstopmode -output-directory=/output "/$1" > /dev/null
xelatex -synctex=1 -interaction=nonstopmode -output-directory=/output "/$1" > /output/log.txt

if [ $? -eq 0 ]; then
    echo "Command was successful."
    echo "Feel free to check log.txt for logs."
    # Remove all the auxiliary files
    rm -rf /output/*.toc /output/*.synctex.gz /output/*.out
    rm -rf /output/*.log /output/*.run.xml
    rm -rf /output/*.nav /output/*.snm
    rm -rf /output/*.vrb
    rm -rf /output/*.aux
else
    echo "Command failed with an error"
    echo "Please check log.txt for more details."
fi
