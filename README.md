<div align="center">
  <img src="https://github.com/user-attachments/assets/0b5b7dcd-21e6-4b70-b9cf-9dda7830fed1" alt="FrameFlow Logo" width="200" height="200">
  <h1>FrameFlow: Create, Animate, and Share</h1>
</div>

**FrameFlow** is an intuitive iOS application that empowers users to create frame-by-frame animations directly on their device. It allows users to sketch, animate, and share creations seamlessly with support for layers, custom tools, and real-time previews. With **FrameFlow**, creating frame-by-frame animations becomes accessible, fun, and professional.

## Table of Contents 📋

- [Features](#features)
- [Technologies](#technologies)
- [Architecture](#architecture)
- [Testing](#testing)
- [Documentation](#documentation)
- [Requirements](#requirements)

<h2 id="features">Features ⚒️</h2>

### Layer Management
- Easily add, duplicate, and manage multiple layers in your animation.
- Use layer previews to navigate frames, customize opacity, and view individual frames within the project.
- Real-time visual adjustments allow you to keep track of frames.

### Frame-by-Frame Drawing
- Create animations using drawing tools like pencil, brush, and eraser, each with adjustable sizes.
- Utilize shape tools to add pre-defined shapes like circles, squares, and arrows to enhance creativity.
- Smooth transitions between frames make the experience intuitive and fluid.

### Animation Playback and Speed Control
- Play and pause your animations in real-time to preview your work.
- Adjust playback speed to tune your animation timing.
- Share animations in GIF format for social media or messaging.

### Onboarding & Common Interface
- An intuitive onboarding process introduces users to essential tools and features.
- A streamlined UI allows for easy navigation and use of color pickers, layer sheets, and animation speed settings.

<h2 id="technologies">Technologies 💻</h2>

### iOS Frameworks and Languages
- **Swift:** FrameFlow is written entirely in Swift, ensuring high performance and compatibility with modern iOS features.
- **SwiftUI:** Handles most UI elements, providing declarative syntax for responsive layouts and animations.
- **Core Animation:** Used for playback animations, allowing smooth transitions between frames and intuitive layer management.
- **Combine:** Powers the reactive flow of data updates, handling layer changes, color selection, and speed adjustments in real-time.

### Image Processing
- **ImageRenderer:** Utilized for real-time frame previews, allowing users to view miniature frames for each layer without delays.
- **Image Exporting:** Frames are processed for GIF creation, allowing easy sharing and exporting of completed animations.

### Local Storage and Persistence
- **UserDefaults:** Used to store user settings, such as playback speed, last used tools, and color choices.

<h2 id="architecture">Architecture 🏗️</h2>

The **FrameFlow** app follows a MVVM (Model-View-ViewModel) architecture pattern, ideal for managing UI state in SwiftUI applications. This structure allows for smooth interaction between views and underlying data.

### Model
The model layer encapsulates data structures for animation frames, layers, lines, and shapes.

Examples:
- **`Line`**: Stores data for user-drawn lines, including points, color, and type (brush, pencil).
- **`ShapeItem`**: Represents shapes that can be added to the canvas with customizable size and color.

### View
SwiftUI views form the View layer, providing a declarative interface that reacts to state changes automatically.

Examples:
- **`CanvasView`**: Displays the main drawing canvas, handling user input for drawing.
- **`LayerSheetView`**: Shows layer management options, allowing the user to add, delete, or select layers.

### ViewModel
The ViewModel handles logic for drawing, managing layers, and updating the UI. It is responsible for processing user actions, such as adding new layers, shapes, or playing animations.

Examples:
- **`CanvasViewModel`**: Manages all layer-related actions, undo/redo operations, and controls for drawing.
- **`OnboardingViewModel`**: Controls the onboarding flow, ensuring users understand app functionality.

<h2 id="testing">Testing 🧪</h2>

### Unit Testing

Unit tests verify core functionality in isolation to ensure robust behavior across key areas of the app.

**CanvasModelTests**: Tests for validating layer and line management.
Examples:
- **`testAddLayer`**: Ensures new layers are added at the correct index.
- **`testUndoRedoLayerAddition`**: Tests undo and redo actions for accurate layer addition.

<h2 id="documentation">Documentation 📚</h2>
FrameFlow’s code is documented following Apple’s DocC format. This documentation covers:

- **Classes and Methods**: Detailed explanations of each class, method, and property.
- **Parameters and Returns**: Clear documentation of parameters and return types to aid in readability and debugging.

### Example:
```swift
/// Adds a new layer at the current index and sets it as active.
/// - Adds an empty layer to the layers array and updates `currentLayerIndex` to point to the new layer.
internal func addLayer() {
    // Code implementation
}
```

<h2 id="requirements">Requirements ✅</h2>

- Xcode 15.0+
- Swift 5.0+
- iOS 17.0+
