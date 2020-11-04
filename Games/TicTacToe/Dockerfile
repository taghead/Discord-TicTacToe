FROM python
WORKDIR /root
RUN wget -O - https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/blob/master/Games/TicTacToe/requirements.txt
RUN wget -O - https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/blob/master/Games/TicTacToe/setup.sh
RUN pip install -r requirements.txt
RUN chmod +x /root/setup.sh
CMD ["/root/setup.sh"]
