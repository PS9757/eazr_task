# eazr

A new Flutter project following Clean Code Architecture.

## Features

- **Bottom Navigation Bar with Three Tabs:**
    1. **Home:**
        - Contains two sections:
            - **Popular News**: Displays a list of popular news items. Clicking on an item navigates to the detail page.
            - **Top Stories**: Highlights the most significant news stories.
    2. **Search News:**
        - Allows users to search for news based on a query.
        - Supports pagination for seamless scrolling through results.
    3. **Categories:**
        - Displays news categorized by specific topics.

## Getting Started

This project is a starting point for a Flutter application built with Clean Code principles. It separates the application into well-defined layers to ensure scalability and maintainability.

### Key Layers
- **Presentation Layer:** Handles the UI and user interaction.
- **Domain Layer:** Includes business logic and entities.
- **Data Layer:** Manages data sources such as APIs and local databases.

### Folder Structure
```plaintext
lib/
|-- core/
|-- features/
    |-- home/
    |-- search/
    |-- categories/
|-- shared/
```

### Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
