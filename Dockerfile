FROM python:3.7.9-alpine
RUN wget https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/raw/master/Games/TicTacToe/requirements.txt -P /root/ \
        && wget https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/raw/master/Games/TicTacToe/setup.sh -P /root/ \
        && apk add --no-cache build-base git \
        && pip install --no-cache-dir -r /root/requirements.txt \
        && chmod +x /root/setup.sh && /root/setup.sh \
        && apk del build-base git
CMD ["/root/setup.sh", "--start-new-config", "--skip-package-install", "--dont-use-virtual-environment"]