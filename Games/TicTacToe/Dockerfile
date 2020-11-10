FROM python:3.7.9-alpine
WORKDIR /root
COPY requirements.txt requirements.txt
RUN apk add --no-cache git && apk add --no-cache build-base && pip install -r requirements.txt
COPY setup.sh setup.sh
RUN chmod +x /root/setup.sh && /root/setup.sh
CMD ["/root/setup.sh", "--start-new-config", "--skip-package-install", "--dont-use-virtual-environment"]