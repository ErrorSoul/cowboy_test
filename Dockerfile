# Build stage 0
FROM erlang:alpine

RUN wget https://erlang.mk/erlang.mk
RUN apk add make

WORKDIR /app

COPY . ./

RUN make
EXPOSE 8080
CMD ["./_rel/hello_erlang_release/bin/hello_erlang_release", "foreground" ]