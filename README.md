
# Venues App

Welcome to the Venues app! This Flutter application allows users to explore and discover venues around predefined coordinates. The app fetches venue data using the Wolt API and offers features such as favorite marking and real-time location updates.

## Table of Contents

- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Architecture](#architecture)
- [Error Handling](#error-handling)

## Description

This application leverages a set of location coordinates to present a curated list of nearby venues. A maximum of 15 venues are showcased at once. The application continuously updates the displayed venues by extracting the current location from the coordinates list, refreshing every 10 seconds.

Moreover, the app offers a personalized touch with a 'favorite' action associated with each venue. Users can mark their preferred venues as favorites, and these selections are conveniently stored using local device storage for quick access and retrieval. The venue list is sorted to show the favorite venues first. 

Also, the user can click on each venue to see more details such as rating and estimate delivery time.

## Instalation

Clone this repository to your local machine using:
git clone https://github.com/your-username/restaurant-finder-app.git

Navigate to the project directory:
cd venues_app

Install the required dependencies:
flutter pub get

## Usage
Usage
Run the app on an emulator or a physical device:
flutter run

The app will display a list of restaurants near the predefined coordinates. You can mark restaurants as favorites by tapping the "Favorite" button next to each restaurant.

The app will automatically update the location every 10 seconds, providing you with a real-time view of nearby restaurants.

## Architecture 
The Venues App follows a modular and layered architecture to ensure maintainability and scalability. Here's an overview of the different architectural layers:

- Models: Defines the data structures representing API objects. Models include methods to parse data from JSON.

- Remote Datasource: Fetches data from the API using an API client and transforms it to models using fromJson methods.

- Service: Serves as an abstraction for data fetching, handling additional logic such as error handling and logging.

- ViewModel/Provider: Manages the business logic, state, and data flow between the UI and other layers. Utilizes Riverpod for state management and dependency injection.

- UI (Widgets): Contains visual components responsible for rendering UI and handling user interactions.

This architecture promotes separation of concerns, allowing for easy testing, maintainability, and collaboration among developers.

The app's Riverpod providers include:

- restaurantsServiceProvider: Provides the service for fetching restaurant data from the Wolt API.
- restaurantsProvider: Fetches restaurant data based on provided coordinates using the 
- restaurantsServiceProvider.
- restaurantCoordinatesProvider: Manages the current coordinates and updates them every 10 seconds for location updates.
- favoriteRestaurantsControllerProvider: Manages favorite restaurants and their IDs.

## Error Handling

The app implements robust error handling to provide a smooth user experience even in the presence of unexpected errors. Error handling is categorized into different exception classes:

BaseException: Base class for exceptions, including a message, stack trace, and log level.

ServerException: A subclass of BaseException specifically for server-related errors. It maps DioExceptions to appropriate log levels based on HTTP status codes.

UnmappedException: Handles unexpected errors that aren't explicitly mapped to other exceptions. Provides a default error message.

GetRestaurantsException: A specific exception related to getting restaurant data. Extends ServerException and provides a custom error message.

In the UI layer, errors are displayed using the provided exception widget. The widget extracts the error message from the exception and offers a "Refresh" button to trigger a data refresh.

