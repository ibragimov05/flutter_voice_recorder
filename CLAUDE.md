# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter voice recorder application that allows users to record audio messages, play them back, and manage their recordings. The app demonstrates fundamental Flutter concepts including state management, file I/O, audio recording/playback, and permission handling.

## Key Dependencies

- `record: ^6.0.0` - Audio recording functionality
- `just_audio: ^0.10.4` - Audio playback
- `path_provider: ^2.1.5` - File system path access
- `permission_handler: ^12.0.0` - Microphone permission management

## Architecture & Code Structure

The project follows a clean, feature-based architecture:

### Core Components

- **Main Entry Point**: `lib/main.dart` - Application bootstrap with error handling using `runZonedGuarded`
- **App Widget**: `lib/src/common/app.dart` - Root MaterialApp configuration
- **Voice Recording Screen**: `lib/src/feature/screens/voice_recorder_screen.dart` - Main UI screen
- **Voice Controller**: `lib/src/feature/controllers/voice_controller.dart` - Business logic and state management
- **Logger**: `lib/src/common/logger.dart` - Simple logging utility

### Architecture Pattern

The app uses a **Controller-Screen pattern** where:
- `VoiceController` is an abstract class extending `State<VoiceRecorderScreen>`
- `_VoiceRecorderScreenState` extends `VoiceController` to inherit business logic
- This pattern separates UI from business logic while maintaining Flutter's reactive state management

### Key Features

1. **Audio Recording**: Long-press to record, release to stop
2. **Audio Playback**: Tap recordings to play them back
3. **File Management**: Recordings stored in app documents directory with timestamps
4. **Permission Handling**: Runtime microphone permission requests
5. **State Management**: Simple setState-based reactive UI updates

## Development Commands

### Standard Flutter Commands
```bash
# Install dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Build for release
flutter build apk          # Android
flutter build ios          # iOS

# Run tests
flutter test

# Analyze code
flutter analyze

# Clean build artifacts
flutter clean
```

### Code Quality & Linting
The project uses comprehensive linting rules defined in `analysis_options.yaml` with:
- Strict type checking enabled
- Comprehensive pedantic rules
- Material Design best practices
- 120 character line length limit

Run analysis with:
```bash
flutter analyze
```

## File Structure Patterns

- **Feature Organization**: Code organized by feature in `lib/src/feature/`
- **Common Utilities**: Shared code in `lib/src/common/`
- **Part Files**: Controller uses `part of` directive for tight coupling with screen

## Audio File Management

- **Storage Location**: Application documents directory
- **File Format**: MP3 with AAC-LC encoding
- **Naming Convention**: `recording_<timestamp>.mp3`
- **Cleanup**: Manual deletion through UI

## Permission Requirements

- **Android**: `RECORD_AUDIO` permission
- **iOS**: Microphone usage description in Info.plist

## State Management Approach

The app uses Flutter's built-in `setState` for state management with:
- Local state variables prefixed with underscore (`_isRecording`, `_recordings`)
- Reactive UI updates through `setState` calls
- Error handling with try-catch blocks and logging

## Testing Strategy

Use Flutter's standard testing framework:
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart
```

## Common Development Tasks

- **Adding new recordings features**: Extend `VoiceController` class
- **UI modifications**: Update `VoiceRecorderScreen.build()` method
- **Audio format changes**: Modify `RecordConfig` in `_startRecording()`
- **Storage location changes**: Update `_fetchAllRecordings()` method