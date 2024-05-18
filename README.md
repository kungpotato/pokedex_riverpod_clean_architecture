# POKEDEX

This is a simple project for using Riverpod with clean architecture.

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
   dart pub global activate slidy
   ```
   ```bash
   slidy run gen
   ```
    ```bash
   dart pub global activate mason_cli
   ```
    ```bash
   mason get
   ```

3. **Install Dependency**
   ```bash
   dart pub get
   ```

### Folder Structure

   ```bash
lib
├── app
│   ├── data
│   │   ├── data_sources
│   │   │   ├── local
│   │   │   │   └── user_local_data_source.dart
│   │   │   ├── remote
│   │   │   │   └── pokemon_remote_data_source.dart
│   │   │   └── rtf
│   │   │       └── pokemon_data_source
│   │   │           ├── pokemon_rtf_data_source.dart
│   │   │           └── pokemon_rtf_data_source.g.dart
│   │   ├── imp_repositories
│   │   │   └── pokemon_repo_imp.dart
│   │   └── models
│   │       ├── another
│   │       │   └── another_model.dart
│   │       ├── pokemon
│   │       │   ├── pokemon_model.dart
│   │       │   └── pokemon_model.g.dart
│   │       └── user
│   │           └── user_model.dart
│   ├── domain
│   │   ├── entities
│   │   │   └── pokemon
│   │   │       └── pokemon.dart
│   │   ├── repositories
│   │   │   └── pokemon_repository.dart
│   │   └── use_cases
│   │       └── get_pokemon.dart
│   └── presentation
│       ├── common
│       │   ├── utils
│       │   │   └── mappers.dart
│       │   └── widgets
│       │       └── component.dart
│       └── home
│           ├── home_page.dart
│           ├── notifiers
│           │   ├── home_notifier.dart
│           │   ├── home_notifier.g.dart
│           │   └── state
│           │       └── home_state.dart
│           └── widgets
│               └── pokemon_item.dart
├── core
│   ├── api
│   │   └── api_end_point.dart
│   ├── error
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network
│   │   └── network_info.dart
│   ├── providers
│   │   ├── data_source
│   │   │   ├── pokemon_remote_data_source_provider.dart
│   │   │   └── user_local_data_source_provider.dart
│   │   ├── dio_provider.dart
│   │   ├── network_provider.dart
│   │   ├── repository
│   │   │   └── pokemon_repository_provider.dart
│   │   └── storage_provider.dart
│   ├── routes
│   │   └── routes.dart
│   ├── themes
│   │   └── light_theme.dart
│   ├── use_cases
│   │   └── use_case.dart
│   └── utils
│       └── extensions.dart
├── main.dart
└── observers.dart
   ```