FROM python:3.11-alpine as requirements

RUN pip install pipenv

COPY Pipfile .
COPY Pipfile.lock .

RUN pipenv requirements > requirements.txt



FROM python:3.11-alpine

WORKDIR /usr/local/clock

COPY --from=requirements requirements.txt .

RUN pip install -r requirements.txt

COPY . .

ENV BOT_TOKEN=token

CMD ["python", "-u", "clock/clock.py"]
