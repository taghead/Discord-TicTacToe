FROM python
WORKDIR /root
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY setup.sh setup.sh
RUN chmod +x /root/setup.sh && /root/setup.sh
CMD ["/root/setup.sh", "-snc"]