# ToteTracker

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android-green.svg)](https://developer.android.com/)
[![Status](https://img.shields.io/badge/Status-Work%20in%20Progress-yellow.svg)]()

A smart storage tracking application for Android devices that helps you organize and track items in your storage containers with AI-powered categorization and barcode scanning capabilities.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Setup](#setup)
- [Usage](#usage)
- [Project Status](#project-status)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)
- [License](#license)

## Overview

ToteTracker is a comprehensive storage tracking application designed for Android devices. It creates a local SQLite database on your device to maintain a complete inventory of all your storage containers and their contents, making it easy to find items when you need them.

Whether you're organizing a garage, storage unit, or just trying to keep track of seasonal items, ToteTracker provides intelligent tools to categorize and locate your belongings efficiently.

## Features

### Core Functionality
- **Local SQLite Database**: All data is stored locally on your device for privacy and offline access
- **Container Management**: Track multiple storage containers with unique QR code identification
- **Item Cataloging**: Add, edit, and search for items with detailed descriptions and images
- **Database Backup**: Export and import your database using your device's built-in sharing options

### Smart Categorization
- **AI-Powered Analysis**: Automatically name and classify objects using Google Gemini AI image analysis
- **Barcode Scanning**: Alternative to AI analysis using the [UPCItemDB API](https://www.upcitemdb.com/) for product identification
- **Image Storage**: Item photos are stored as base64-encoded strings directly in the database

### Container Tracking
- **QR Code Integration**: Scan stickers created by the [QR Sticker Generator](https://github.com/ThatMattCat/qr-sticker-generator)
- **Visual Organization**: Keep track of which items are in which containers
- **Search Functionality**: Quickly find items across all containers

## Screenshots

<table>
  <tr>
    <td align="center">
      <img src="media/homepage.jpg" width="200" height="400"><br>
      <b>Home Screen</b><br>
      <em>Main dashboard with container overview</em>
    </td>
    <td align="center">
      <img src="media/container-contents.jpg" width="200" height="400"><br>
      <b>Container Contents</b><br>
      <em>View all items in a specific container</em>
    </td>
    <td align="center">
      <img src="media/item-search.jpg" width="200" height="400"><br>
      <b>Item Search</b><br>
      <em>Find items across all containers</em>
    </td>
    <td align="center">
      <img src="media/new-item.jpg" width="200" height="400"><br>
      <b>Add New Item</b><br>
      <em>Add items with AI categorization</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="media/settings.jpg" width="200" height="400"><br>
      <b>Settings</b><br>
      <em>Configure API keys and preferences</em>
    </td>
    <td colspan="3"></td>
  </tr>
</table>

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Included with Flutter
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK**: For Android development
- **Git**: For version control

### API Keys (Optional but Recommended)

- **Google Gemini API Key**: For AI-powered image analysis and automatic item categorization
  - Sign up at [Google AI Studio](https://makersuite.google.com/app/apikey)
  - The app will function without this, but you'll miss out on automated categorization

## Installation

### Option 1: Clone and Build from Source

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ThatMattCat/ToteTracker.git
   cd ToteTracker
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### Option 2: Download APK (Coming Soon)

Pre-built APK releases will be available in the [Releases](https://github.com/ThatMattCat/ToteTracker/releases) section.

## Setup

### Initial Configuration

1. **Launch the app** on your Android device
2. **Navigate to Settings** (gear icon)
3. **Configure API Keys** (optional):
   - Enter your Google Gemini API key for AI features
   - This enables automatic item name generation and categorization

### Container Setup

1. **Generate QR Stickers**: Use the [QR Sticker Generator](https://github.com/ThatMattCat/qr-sticker-generator) to create container labels
2. **Attach Stickers**: Place QR code stickers on your storage containers
3. **Scan Containers**: Use the app to scan and register each container

## Usage

### Adding Items

1. **Open a Container**: Select a container from the home screen
2. **Add New Item**: Tap the "+" button
3. **Take a Photo**: Capture an image of the item
4. **AI Analysis** (if configured): The app will automatically suggest a name and category
5. **Manual Entry**: Fill in any additional details
6. **Save**: Your item is now tracked in the container

### Finding Items

1. **Use Search**: Enter item names or descriptions in the search bar
2. **Browse Containers**: Navigate through containers to view contents
3. **Recent Items**: Check the recently added items section

### Backup and Restore

1. **Export Database**: Go to Settings > Backup Database
2. **Share File**: Use your device's sharing options to save or send the database file
3. **Import Database**: Use the import option to restore from a backup file

## Project Status

🚧 **Work in Progress**: This application is in a functional "good enough" state for its intended purpose but has several known limitations:

- UI/UX improvements needed
- Some features may have minor quirks
- Ongoing development and refinement

Despite these limitations, the core functionality is stable and the app is fully usable for storage tracking purposes.

## Technologies Used

- **[Flutter](https://flutter.dev/)**: Cross-platform mobile development framework
- **[FlutterFlow](https://flutterflow.io/)**: Visual Flutter development platform
- **[SQLite](https://www.sqlite.org/)**: Local database storage
- **[Google Gemini AI](https://deepmind.google/technologies/gemini/)**: AI-powered image analysis
- **[UPCItemDB API](https://www.upcitemdb.com/)**: Barcode product lookup
- **Dart**: Programming language

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is available under the MIT License. See the LICENSE file for more details.

---

**Built with ❤️ using Flutter and FlutterFlow**
