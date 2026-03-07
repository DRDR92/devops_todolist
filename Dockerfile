
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}

ARG MY_ARG=default
ENV MY_ENV=${MY_ARG}


WORKDIR /app

COPY app.py .
COPY docker-logo.png .

RUN pip install Flask

EXPOSE 8080

ENTRYPOINT ["python","app.py"]