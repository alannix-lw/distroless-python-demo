FROM python:3.9-buster AS build-env

WORKDIR /app

COPY requirements.txt /app

RUN pip3 install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

FROM gcr.io/distroless/python3

COPY --from=build-env /app /app
COPY --from=build-env /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

WORKDIR /app
ENV PYTHONPATH=/usr/local/lib/python3.9/site-packages
