<h1 align="center">Attack on Titan Characters App</h1>

![cover3](https://github.com/user-attachments/assets/6b1491ab-2814-4b3d-8a95-213ab9716e0c)

## Description

A simple iOS app built with SwiftUI to fetch and display information about characters from *Attack on Titan*. The app uses Apple's modern UI framework, SwiftUI, and follows a clean architecture approach to deliver a minimal, elegant, and responsive user experience.

## App Images  
Splash | All | All  
--- | --- | ---  
![aot1](https://github.com/user-attachments/assets/202ad3d7-3fb2-481a-8f65-b1942a29cbad) | ![aot2](https://github.com/user-attachments/assets/5413b59e-e98e-4872-818e-765522ab561f) | ![aot3](https://github.com/user-attachments/assets/914b23ca-ec94-4a38-83d8-7a6bd708cbc8)

| Details | Search  
--- | ---  
![aot4](https://github.com/user-attachments/assets/6a154373-a074-41be-92a3-72e6bc7c1138) | ![aot5](https://github.com/user-attachments/assets/f43b1ef3-bdef-42b4-b805-a64cf2c2f574)

<br />

## Project Structure 📁

This SwiftUI project is built using **Clean Architecture**, ensuring modularity, maintainability, and testability. The structure is organized as follows:

- `Core/`: Contains networking logic (`APIClient`, endpoints, and constants) shared across the app.
- `Data/`: Includes Data Transfer Objects (DTOs) and repository implementations that fetch and map API data.
- `Domain/`: Defines business logic, including `Entities`, `UseCases`, and `RepositoryProtocols` for abstraction.
- `Presentation/`: Organized by feature (`Characters`, `CharacterDetails`, `Splash`), each with:
  - `Views`: SwiftUI views for screens and subcomponents.
  - `ViewModels`: Logic and state for each view, using ObservableObject.
  - `Components`: Reusable UI components (e.g., rows, image views, search bars).
- `Resources/`: Contains app assets (icons, splash image) and localized strings.
- `AOTCharactersApp.swift`: The main entry point initializing the app.

This structure promotes a clear separation of concerns across UI, domain logic, and data layers, making it easier to develop and scale features independently.

![CleanArchitecture](https://github.com/user-attachments/assets/e0695060-f965-45c4-ae2b-d3f30cce9df8)

## Technologies 🛠️

This project uses modern iOS technologies to deliver a robust and user-friendly experience:

- **Swift**: A powerful and intuitive language for iOS development.
- **SwiftUI**: A declarative UI framework from Apple for building interfaces across all Apple platforms.
- **MVVM**: A design pattern that separates business logic from UI using ViewModels.
- **Clean Architecture**: Modular structure with Data, Domain, and Presentation layers.
- **Combine** *(optional)*: For reactive state management (can be extended).
- **URLSession**: Native networking to interact with the Attack on Titan API.
- **Async/Await**: For clean and efficient asynchronous programming.
- **SF Symbols and Material Design**: For consistent, modern UI components.

These technologies provide a scalable, efficient, and maintainable foundation for iOS app development.
