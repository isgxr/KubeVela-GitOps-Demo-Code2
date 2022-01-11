FROM golang:1.17.0-alpine3.14 as builder
WORKDIR /app

COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download

COPY static/index.html ./static/index.html
COPY app.go .
RUN go build -o kubevela-demo-app app.go

FROM alpine:3.10
WORKDIR /app
COPY static/index.html ./static/index.html
COPY --from=builder /app/kubevela-demo-app /app/kubevela-demo-app
ENTRYPOINT ./kubevela-demo-app

EXPOSE 9080
