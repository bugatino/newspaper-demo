FROM python:3.8-alpine

RUN adduser -D bugatino

WORKDIR /home/bugatino

COPY requirements.txt requirements.txt
RUN python -m venv myenv
RUN apk add --update --no-cache g++ gcc libxslt-dev libxml2-dev jpeg-dev zlib-dev
RUN myenv/bin/pip install -r requirements.txt
RUN myenv/bin/pip install gunicorn

COPY newspaperdemo newspaperdemo
COPY runserver.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP runserver.py

RUN chown -R bugatino:bugatino ./
USER bugatino

EXPOSE 5000
ENTRYPOINT ["sh", "./boot.sh"]