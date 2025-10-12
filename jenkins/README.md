# Golang JUnit Docker Agent

This Docker agent provides a complete environment for building and testing Go applications with JUnit reporting capabilities for Jenkins CI/CD pipelines.

## What's Included

### Languages & Runtimes
- **Go 1.23** - Latest stable Go version
- **Java 17 (OpenJDK)** - For JUnit test execution and reporting

### Build Tools
- **Maven 3.9.5** - Java dependency management and build tool
- **Make** - Build automation tool

### Go Development Tools
- **golangci-lint** - Go linter aggregator
- **go-junit-report** - Converts Go test output to JUnit XML format
- **goimports** - Updates Go import lines and formats code

### Testing Frameworks
- **JUnit Platform Console Standalone** - For running JUnit tests
- **Go testing** - Built-in Go testing framework

## Usage

### Building the Docker Image

```bash
# Navigate to the jenkins directory
cd jenkins

# Build the image using the provided script
./build-agent.sh

# Or build manually
docker build -f golang-junit-agent -t golang-junit-agent:latest .
```

### Running the Container

```bash
# Interactive shell
docker run -it --rm golang-junit-agent:latest

# With workspace volume mount
docker run -it --rm -v $(pwd):/workspace golang-junit-agent:latest

# Run specific commands
docker run --rm -v $(pwd):/workspace golang-junit-agent:latest go version
```

### Jenkins Pipeline Usage

Use this agent in your Jenkins pipeline by referencing the Dockerfile:

```groovy
pipeline {
    agent {
        dockerfile {
            filename 'jenkins/golang-junit-agent'
            dir '.'
        }
    }
    // ... your pipeline stages
}
```

See `Jenkinsfile-golang` for a complete example pipeline.

### Example Go Testing with JUnit Output

```bash
# Run tests and generate JUnit XML
cd bugtracker-backend
go test -v ./... | go-junit-report -set-exit-code > test-results.xml

# Run with coverage
go test -v ./... -coverprofile=coverage.out
```

## File Structure

```
jenkins/
├── golang-junit-agent     # Dockerfile
├── build-agent.sh        # Build script
├── Jenkinsfile-golang    # Example Jenkins pipeline
├── .dockerignore         # Docker ignore patterns
└── README.md            # This file
```

## Security Features

- Runs as non-root user (`jenkins`) for improved security
- Minimal attack surface with only necessary packages installed
- Regular base image updates through Go official images

## Environment Variables

- `JAVA_HOME`: `/usr/lib/jvm/java-17-openjdk-amd64`
- `MAVEN_HOME`: `/opt/maven`
- `GOPROXY`: Can be set to customize Go module proxy
- `PATH`: Includes Go, Java, and Maven binaries

## Troubleshooting

### Common Issues

1. **Permission Issues**: Ensure your workspace is writable by the jenkins user (UID 1000)
2. **Go Module Issues**: Check `GOPROXY` setting and network connectivity
3. **Java Memory**: For large builds, you may need to increase container memory limits

### Debugging

```bash
# Check tool versions
docker run --rm golang-junit-agent:latest go version
docker run --rm golang-junit-agent:latest java -version
docker run --rm golang-junit-agent:latest mvn -version

# Interactive debugging
docker run -it --rm golang-junit-agent:latest /bin/bash
```

## Customization

To customize this agent for your specific needs:

1. Fork the Dockerfile
2. Add your required tools and dependencies
3. Update the build script if needed
4. Test with your specific pipeline requirements

## Contributing

When making changes to this Docker agent:

1. Test the build process
2. Verify all tools work correctly
3. Update this README if you add new features
4. Consider security implications of any new packages