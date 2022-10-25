FROM golang:alpine AS build-stage
WORKDIR /app
COPY . .
RUN apk add git
RUN go get ./... && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

FROM alpine 
WORKDIR /app
COPY --from=build-stage /app/app /app/
CMD [ "/app/app" ]