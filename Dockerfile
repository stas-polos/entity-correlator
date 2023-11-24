FROM python:3.11.3-slim-bullseye

# last poetry version: https://github.com/python-poetry/poetry
ARG POETRY_VERSION=1.6.1

RUN apt-get update -yq;
RUN apt-get install -yq --no-install-recommends \
    curl \
    gcc \
    build-essential \
    libopenblas-dev \
    ;
RUN pip install --upgrade pip

RUN curl -sSL https://install.python-poetry.org | python - --version ${POETRY_VERSION}
ENV PATH="${PATH}:/root/.local/bin"

COPY pyproject.toml poetry.lock /app/
WORKDIR /app

RUN poetry config virtualenvs.create false && \
    poetry install;

COPY src/ /app/src/
