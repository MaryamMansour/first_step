# FirstStep 

A Cross-Platform Solution for Connecting Startups with Investors

## Project Overview

FirstStep is a mobile application designed to support startups by connecting them with investors through an intuitive platform. It enables entrepreneurs to showcase their projects, engage in real-time communication, and receive AI-powered assistance. The app ensures continuous accessibility and efficient interaction, making it easier for entrepreneurs to establish connections and for investors to discover promising ventures.

## Features

- **User Registration & Profiles:** Allows users to register, log in, and manage profiles for better visibility on the platform.
- **Project Showcase:** Startups can upload and manage project details to attract potential investors.
- **Real-Time Messaging & Group Channels:** Facilitates direct and group communication between users.
- **Push Notifications:** Keeps users informed with instant updates and alerts.
- **AI Chatbot Assistance:** An NLP-powered chatbot provides guidance on business and investment topics.
- **Efficient Data Handling:** Integrated pagination improves data loading by 50%, enhancing performance for large datasets.
- **Feedback & Rating System:** Enables users to rate interactions, ensuring high-quality engagements.
- **Real-World Project Data:** A Python web scraping [script](https://github.com/MaryamMansour/web_scraping) gathers structured information from active startup projects on external hubs, which is directly integrated into the platform to enhance search functionality and provide valuable data for users.

## Tech Stack

### Mobile Application (Frontend)
- **Framework:** Flutter - Cross-platform compatibility for both mobile and web applications.
- **Programming Language:** Dart
- **Dependency Injection:**  Manages dependencies for organized, scalable code.
- **Push Notifications:** FCM: Provides real-time notifications to keep users engaged.
- **Pagination:** Enhances data loading performance by dynamically displaying content as needed, reducing load times by up to 50%.

The following key packages are used in the project, along with their primary usage:

  - flutter_bloc:  State management using the BLoC pattern.
  - get_it:   Dependency injection framework for managing service instances.
  - flutter_secure_storage:   Secure storage for sensitive data like authentication tokens.
  - dio:   Powerful HTTP client for network requests.
  - retrofit:   API client for making RESTful calls.
  - json_serializable:   JSON serialization utilities for converting Dart objects.
  - shared_preferences:   Local storage for saving user preferences.


### Backend (API Integration)
- **API Framework:** Java Spring Boot - Powers backend services with secure, scalable APIs.
- **Database:** MySQL - Manages data for user profiles, projects, and communication.
- **AI & Chatbot:** Python Flask - An NLP-powered chatbot provides guidance and assistance to users.

### Real-Time & Cloud Services
- **Cloud Storage:** Microsoft Azure - Ensures data storage and scalability.
- **Real-Time Messaging:** Firebase - Enables direct messaging and push notifications.

### Additional Tools
- **Design:** Figma and Draw.io - Used for UI/UX design and architecture diagrams.
- **Testing:** Postman - API testing and validation.

## Architecture

The mobile app follows a modular, layered architecture to promote scalability and maintainability:

1. **Presentation Layer:** Developed in Flutter to ensure a responsive and intuitive user interface.
2. **Business Logic Layer:** Utilizes the flutter_bloc package for state management, which keeps the codebase organized and modular.
3. **Data Layer:** Firebase and Azure manage real-time data handling, with pagination ensuring efficient access to large datasets.
4. **Integrated Real-World Data:** Project data collected from real-world sources via a Python web scraping script is incorporated directly into the platform. This data enhances the search functionality and provides users with up-to-date information on trending startups and project ideas.

This architecture enables independent management of each component, making the mobile app scalable and maintainable across platforms.

# For Full Documentation about the project [Here](https://docs.google.com/document/d/1xAtpBVCKmW0jkHlYsKmSrE94uBzMT5Hp/edit?usp=sharing&ouid=112704548038309970121&rtpof=true&sd=true) 

