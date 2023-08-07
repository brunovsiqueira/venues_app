
## Description

Welcome to the Venues app! This Flutter app allows users to explore and discover venues around a predefined set of coordinates. The app fetches restaurant data using the Wolt API and provides features like favorite marking and real-time location updates.

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

## Artchitecture 
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

