FROM golang:1.16.6-alpine3.14 as builder

WORKDIR /app

COPY . /app

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags "-w -s" -installsuffix cgo -o main .

FROM scratch

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main"]