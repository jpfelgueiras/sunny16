# Sunny16

Sunny16 is a Flutter application that helps photographers calculate exposure settings using the Sunny 16 rule. The app provides recommendations for ISO, shutter speed, and aperture settings based on different lighting conditions.

## Features

- Calculate exposure settings using the Sunny 16 rule
- Select lighting conditions and aperture values
- View recommended ISO and shutter speed settings
- Customize camera settings, including ISO values, shutter speed range, and stop increments

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/sunny16.git
   cd sunny16
   ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Run the app:
    ```sh 
    flutter run 
    ```

### Running Tests

To run the tests, use the following command:

```sh
flutter test
```

#### Test Coverage

You can view the test coverage report for this project at [Codecov](https://app.codecov.io/github/jpfelgueiras/sunny16).

## Project Structure
```
sunny16/
├── lib/
│   ├── aperture_selector.dart
│   ├── condition_selector.dart
│   ├── constants.dart
│   ├── home_screen.dart
│   ├── settings_model.dart
│   ├── settings_repository.dart
│   ├── settings_screen.dart
│   ├── sunny16_calculator.dart
│   └── main.dart
├── test/
│   ├── aperture_selector_test.dart
│   ├── condition_selector_test.dart
│   ├── home_screen_test.dart
│   ├── settings_screen_test.dart
│   └── sunny16_calculator_test.dart
├── README.md
└── pubspec.yaml
```



## Resources

A few resources to get you started if this is your first Flutter project:

 - [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
 - [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

 # License
This project is licensed under the MIT License - see the LICENSE file for details.