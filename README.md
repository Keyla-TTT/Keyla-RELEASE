# Keyla - Typing Speed Testing Platform

Keyla is a comprehensive typing speed and accuracy testing platform that provides real-time performance metrics, user profile management, and detailed analytics. The platform consists of a backend API service and a cross-platform CLI application.

## Overview

Keyla offers three different ways to get started, depending on your preferences and requirements:

1. **🐳 Docker + Local CLI (Recommended)** - Run the backend in Docker and use CLI locally
2. **🐳 Container-Only** - Use everything inside a Docker container
3. **💻 Local Installation** - Install both backend and CLI on your machine

## 🚀 Quick Start

### Method 1: Docker + Local CLI (Recommended)

This is the recommended approach for most users.

#### Step 1: Start the Backend Container
```bash
docker run -d --name keyla-backend keylattt/keyla
```

#### Step 2: Install Keyla CLI Locally
Follow the installation instructions in the [Keyla-CLI README](https://github.com/Keyla-TTT/Keyla-CLI/blob/main/README.md) to install the CLI on your local machine.

#### Step 3: Start Typing!
```bash
keyla test
```

**Important:** The Docker container must be running for the CLI to work. You can check if it's running with:
```bash
docker ps
```

### Method 2: Container-Only Usage

If you prefer to use everything inside a Docker container, this approach is perfect for you.

```bash
docker run -it keylattt/keyla
```

This will:
- Start the backend API server automatically
- Give you access to the Keyla CLI inside the container
- Allow you to run typing tests directly in the container

### Method 3: Local Installation

For advanced users who want full control over the installation.

#### Step 1: Install the Backend
Follow the installation instructions in the [Keyla-API README](https://github.com/Keyla-TTT/Keyla-API/blob/main/README.md) to set up the backend API on your local machine.

#### Step 2: Install the CLI
Follow the installation instructions in the [Keyla-CLI README](https://github.com/Keyla-TTT/Keyla-CLI/blob/main/README.md) to install the CLI.

#### Step 3: Configure and Run
```bash
keyla config  # Configure the backend URL
keyla test    # Start typing tests
```

**Important (MongoDB):** If you want to use MongoDB persistence when installing locally, a MongoDB service must be running on your machine or accessible remotely. Set `database.mongoUri` (e.g., `mongodb://localhost:27017`) and ensure `database.useMongoDb` is set according to your needs. If you do not want persistence, set `database.useMongoDb` to `false`.

## 📋 Available Commands

Run `keyla help` to see all available commands:

```bash
keyla help
```

### Main Commands
- `keyla test` - Start a typing test (default mode)
- `keyla config` - Manage backend configuration
- `keyla settings` - Application settings
- `keyla history` - View test history
- `keyla profile` - Manage user profiles
- `keyla stats` - View statistics

## 📊 Features

- **Real-time Metrics**: WPM, accuracy, error tracking
- **User Profiles**: Personalized experience with history
- **Cross-platform**: Works on JVM, Linux, and Windows
- **Modern UI**: Color-coded terminal interface
- **Analytics**: Detailed performance statistics
- **Dictionary Support**: Multiple language dictionaries

## 🔧 Troubleshooting

### CLI Connection Issues
If the CLI can't connect to the backend:
1. Ensure the container is running: `docker ps`
2. Check the backend URL in config: `keyla config`
3. Verify the port is accessible: `curl http://localhost:9999/health`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

We welcome contributions! Please see the individual component READMEs for development setup instructions.

## 📚 Documentation

- [Keyla-CLI Documentation](Keyla-CLI/README.md)
- [Keyla-API Documentation](Keyla-API/README.md)
- [Keyla-REPORT Documentation](Keyla-REPORT/README.md)
