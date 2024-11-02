# Artwork App

An interactive mobile app to browse, search, and view details about artworks from the Art Institute of Chicago's API.

## Features

- **Search Artworks**: Find artworks by entering search queries.
- **View Artwork Details**: Tap on an artwork to see detailed information.
- **Infinite Scrolling**: Continuously load more artworks as you scroll.
- **Refresh List**: Pull to refresh the list of artworks.

## Screenshots

Include screenshots of the app here.

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Android Studio or Visual Studio Code: For running and debugging the app

### Steps

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/artwork_app.git
    cd artwork_app
    ```

2. **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the App**:
    ```bash
    flutter run
    ```

## Configuration

### Android

1. Open `android/app/src/main/AndroidManifest.xml`.
2. Add the following permissions within the `<manifest>` tag:
    ```xml
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    ```

### iOS

1. Open `ios/Runner/Info.plist`.
2. Ensure the following key is present:
    ```xml
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    ```

## Usage

### Main Screens

- **Splash Screen**: Appears for 4 seconds when the app is launched.
- **Home Screen**: Displays a list of artworks.
- **Detail Screen**: Shows detailed information about a selected artwork.

## Code Overview

### Splash Screen

Located in `lib/splash_screen.dart`, it displays an icon and a welcome message for 2 seconds before navigating to the home screen.

### Home Screen

Located in `lib/home_screen.dart`, it contains the main layout of the app, including the search bar and list of artworks.

### Artwork Model

Located in `lib/artwork.dart`, it defines the `Artwork` class used to parse JSON data from the API.

### Detail Screen

Located in `lib/artwork_detail.dart`, it displays detailed information about a selected artwork.

### Fetching Data

Data is fetched from the Art Institute of Chicago's API and displayed in the app. The fetching logic is implemented in `lib/search_page.dart`.

## Contact

Created by Sidhant- feel free to contact me!

