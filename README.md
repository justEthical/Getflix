# Getflix

Getflix is an iOS application that allows users to search and view details of movies using an external movie API. The app is built using Swift 5 and UIKit with Storyboard, and it leverages the SDWebImage library for efficient image loading and IQKeyboardManager for better keyboard management.

## Screenshots
![Simulator Screenshot - iPhone 15 Pro Max - 2024-07-26 at 22 08 21](https://github.com/user-attachments/assets/5d13231b-2949-4c5c-bdc1-3461caff9e41)
![Simulator Screenshot - iPhone 15 Pro Max - 2024-07-26 at 22 07 36](https://github.com/user-attachments/assets/847217bd-8538-4023-b81e-296d7b17b47b)
![Simulator Screenshot - iPhone 15 Pro Max - 2024-07-26 at 22 06 57](https://github.com/user-attachments/assets/8cbc7c95-db8b-47d4-b61e-17fa3f883a42)

## Features

- **Fetch and Display Movies**: The app fetches movie details from an external API and displays them in a list format.
- **Search Movies**: Users can search for movies within the fetched list.
- **Detailed Movie Screen**: Tapping on a movie from the list navigates the user to a detailed screen with more information about the selected movie.
- **Pull to Refresh**: Users can pull down on the movie list to refresh the data.
- **Network Image Loading**: Images are loaded asynchronously from the network using the SDWebImage library.
- **Keyboard Management**: The app uses IQKeyboardManager for managing the keyboard, ensuring a smooth user experience when interacting with input fields.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/getflix.git
   cd getflix
