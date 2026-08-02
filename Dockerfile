FROM golang:1.23-alpine AS build
WORKDIR /src
COPY go.mod ./
COPY main.go ./
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /sample-api .

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /sample-api /sample-api
USER 65532
EXPOSE 8080
ENTRYPOINT ["/sample-api"]
