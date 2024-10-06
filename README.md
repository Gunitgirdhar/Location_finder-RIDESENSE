# Location Finder App

This Flutter application allows users to input a location or coordinates and view it on a Google Map. The app provides a user-friendly interface for entering locations or coordinates and displays the selected location on the map with different map views.

## Features

- Input location or coordinates.
- Display selected location on Google Maps.
- Option to change map view (Normal, Satellite, Terrain, Hybrid).

## Screenshots

### First Page
![First Page Screenshot](https://github.com/Gunitgirdhar/Location_finder-RIDESENSE/blob/16147c0b18bab1e6edf966a634f802156133d61c/01.jpg)

### Second Page
![Second Page Screenshot](path_to_second_page_screenshot)

## How to Clone and Run the Project

To clone this project, follow these steps:

1. Copy the GitHub repository link: [GitHub Repository Link](https://github.com/Gunitgirdhar/Location_finder-RIDESENSE).
2. Open Android Studio (or any other IDE you prefer).
3. Go to `File` -> `New` -> `Project from Version Control...`.
4. Paste the copied link in the URL field and choose your preferred directory.
5. Click on `Clone`.

After cloning the project, follow these steps to run it:

1. Open the project in Android Studio.
2. Make sure you have Flutter and Dart plugins installed.
3. Ensure your emulator is running or a physical device is connected.
4. Run the app using the play button in Android Studio.

## Code Overview

### First Page (LocationInputPage)

The first page allows users to enter either a location name or coordinates (latitude and longitude). It consists of:

- A dropdown to choose between "Location" and "Coordinates".
- Text fields to input the location or coordinates.
- Buttons to navigate to the map page or get the current location.

### Second Page (MapDisplayPage)

The second page displays the selected location on Google Maps. It includes:

- A Google Map widget initialized with the provided latitude and longitude.
- A floating action button that allows users to switch between different map types (Normal, Satellite, Terrain, Hybrid).

## How to Run the App

1. Make sure you have Flutter installed and set up on your machine.
2. Run `flutter pub get` to install necessary dependencies.
3. Use the command `flutter run` in the terminal to start the app.

## Dependencies

- `flutter`
- `geolocator`
- `geocoding`
- `google_maps_flutter`



