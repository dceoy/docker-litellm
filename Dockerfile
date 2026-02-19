FROM docker.litellm.ai/berriai/litellm:main-stable

WORKDIR /app

COPY config.yml .

EXPOSE 4000/tcp

ENTRYPOINT ["litellm"]
CMD ["--port", "4000", "--config", "config.yml"]
