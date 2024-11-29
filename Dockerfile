# Stage 1: Build the Go application
FROM golang:1.23.3 AS builder

# Set environment variables for Go build
ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
    GO111MODULE=on

# Create and set the working directory
WORKDIR /app

# Cache dependencies by copying go.mod and go.sum first
COPY app/go.mod app/go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the application source code
COPY app/ ./

# Build the application binary
RUN go build -o server ./cmd/main.go

# Stage 2: Create a minimal runtime environment
FROM gcr.io/distroless/base-debian12

# Expose the server port
EXPOSE 8080

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/server .

# Set the binary as the entrypoint
ENTRYPOINT ["/app/server"]

