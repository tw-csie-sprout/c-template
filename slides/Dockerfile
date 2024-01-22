FROM ubuntu:22.04
LABEL maintainer="iceylemon"

ENV TZ Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y tzdata git
RUN apt-get install -y fontconfig fonts-noto-cjk

# Install fira sans/mono font
RUN git clone https://github.com/bBoxType/FiraSans.git && \
    cp -r FiraSans/Fira_Mono_3_2/Fonts/ /usr/share/fonts/ && \
    cp -r FiraSans/Fira_Sans_4_3/Fonts/ /usr/share/fonts/ && \
    rm -rf FiraSans

RUN fc-cache -f -v

# Install texlive
RUN apt-get install -y texlive-xetex texlive-lang-chinese

# 裝酷酷的 CC Icons
RUN apt-get install -y make fontforge texlive-font-utils
RUN git clone https://github.com/ummels/ccicons.git
RUN cd ccicons && make install && texhash && updmap --sys --enable Map=ccicons.map && \
    cd .. && apt-get purge -y git make fontforge texlive-font-utils && rm -rf ccicons

# maybe not needed, depends on your tex file
# RUN apt-get install -y biber
# RUN apt-get install -y texlive-bibtex-extra
# RUN apt-get install -y texlive-science biber
# RUN apt-get install -y texlive-bibtex-extra
# RUN apt-get install -y texlive-fonts-recommended
# RUN apt-get install -y texlive-fonts-extra

# Cleanup unnecessary files to reduce image size
# Doesn't seem to work? - iceylemon
# RUN apt-get autoremove -y && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/* /usr/src/app/*.log /usr/src/app/*.aux

COPY entrypoint.sh /entrypoint.sh
COPY template.tex /template.tex
RUN chmod +x /entrypoint.sh
VOLUME [ "/output" ]

ENTRYPOINT [ "/entrypoint.sh" ]
