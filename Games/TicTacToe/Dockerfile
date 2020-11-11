FROM python:3.7.9-alpine
COPY requirements.txt /root/requirements.txt
COPY setup.sh /root/setup.sh
RUN apk add --no-cache build-base git && pip install -r /root/requirements.txt && chmod +x /root/setup.sh && /root/setup.sh && apk del build-base git
CMD ["/root/setup.sh", "--start-new-config", "--skip-package-install", "--dont-use-virtual-environment"]