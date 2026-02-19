FROM docker.litellm.ai/berriai/litellm:main-stable

WORKDIR /app

COPY config.yaml .

EXPOSE 4000/tcp

ENTRYPOINT ["litellm"]
CMD ["--port", "4000", "--config", "config.yaml"]
