# POKEDEX

This is a simple project for using Riverpod with clean architecture.

![alt text](https://raw.githubusercontent.com/kungpotato/pokedex_riverpod_clean_architecture/micro-kernel/docs/Screenshot%202567-05-21%20at%2011.09.05.png)

## Installation

Follow these steps to set up the project locally. This guide assumes that you have already installed
Flutter on your system.

### Prerequisites

Before you begin, ensure you have Flutter installed. If Dart is not installed, you can download and
install it from [Flutter's official site](https://docs.flutter.dev/get-started/install).

### Setup

1. **Clone the project**
   ```bash
   git clone https://github.com/kungpotato/pokedex_riverpod_clean_architecture.git

2. **Install tools**
   ```bash
   dart pub global activate melos
   ```
   ```bash
   melos bootstrap
   ```
    ```bash
   melos generate:flutter
   ```
   ```bash
   dart pub global activate mason_cli
   ```

3. **Create folder structure**

   To create a folder structure using Mason and ensure that all directories are created (even if
   they are empty), follow these steps:

   ```bash
   mason get
   ```
   ```bash
   mason make folder_structure
   ```

   To create standalone app

   ```bash
   flutter create [app_name] --platform=ios,android --org [app_id]
   ```

### Folder Structure

   ```bash
lib
├── app
│   ├── data
│   │   ├── data_sources
│   │   │   ├── local
│   │   │   ├── remote
│   │   │   └── rtf
│   │   ├── imp_repositories
│   │   └── models
│   │       ├── another
│   │       ├── pokemon
│   │       └── user
│   ├── domain
│   │   ├── entities
│   │   │   └── pokemon
│   │   ├── repositories
│   │   └── use_cases
│   └── presentation
│       ├── common
│       │   ├── utils
│       │   └── widgets
│       └── home
│           ├── notifiers
│           │   └── state
│           └── widgets
├── core
│   ├── api
│   ├── error
│   ├── network
│   ├── providers
│   │   ├── data_source
│   │   ├── repository
│   ├── routes
│   ├── themes
│   ├── use_cases
│   └── utils
   ```