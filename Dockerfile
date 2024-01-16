#Builder
FROM golang:1.21 as builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY *.go ./
RUN go build -v -o main .

#PROD
FROM scratch

WORKDIR /root/

COPY --from=builder /app/main .
#RUN chown -R www-data:www-data /app
EXPOSE 8080
CMD [ "./main" ]