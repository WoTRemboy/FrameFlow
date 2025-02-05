<div align="center">
  <img src="https://github.com/user-attachments/assets/3988a9dd-cb0a-4c58-abb0-c3f6127a3f6b" alt="FrameFlow Logo" width="200" height="200">
  <h1>FrameFlow: Create, Animate, and Share</h1>
</div>

**FrameFlow** is an intuitive iOS application that empowers users to create frame-by-frame animations directly on their device. It allows users to sketch, animate, and share creations seamlessly with support for layers, custom tools, and real-time previews. With **FrameFlow**, creating frame-by-frame animations becomes accessible, fun, and professional.

Find it in [TestFlight](https://testflight.apple.com/join/JnESsmYu). Full Demo available on my [Google Drive](https://drive.google.com/file/d/1Yg0PAA3iBzdOuVMtC8cIpsb5S-7Q0oLw/view).

## Table of Contents 📋

- [Features](#features)
- [Technologies](#technologies)
- [Contextual Menus](#menus)
- [Architecture](#architecture)
- [Testing](#testing)
- [Documentation](#documentation)
- [Requirements](#requirements)

<h2 id="features">Features ⚒️</h2>

### Frame-by-Frame Drawing
- Create animations using drawing tools like pencil, brush, and eraser, each with adjustable sizes.
- Utilize shape tools to add pre-defined shapes like circles, squares, and arrows to enhance creativity.
- Smooth transitions between frames make the experience intuitive and fluid.

<img src="https://github.com/user-attachments/assets/0f211349-036c-4121-8db6-b079cc41759b" alt="Drawing demo" width="200" height="435">
<img src="https://github.com/user-attachments/assets/847997ed-7d61-4775-a7a7-af90f483f625" alt="Tools" width="200" height="435">
<img src="https://github.com/user-attachments/assets/68905b54-5dac-4d37-87a5-ac2b92adf3b5" alt="Shapes" width="200" height="435">

### Layer Management
- Easily add, duplicate, and manage multiple layers in your animation.
- Use layer previews to navigate frames, customize opacity, and view individual frames within the project.
- Real-time visual adjustments allow you to keep track of frames.

<img src="https://github.com/user-attachments/assets/a757b403-e67e-4e00-89dc-00f789b6f326" alt="Layer Management Demo" width="200" height="435">
<img src="https://github.com/user-attachments/assets/ceeca2e3-aa84-4e96-b2fc-850da7753d5f" alt="Storyboard" width="200" height="435">

### Generation Parameters, Animation Playback and Speed Control
- Play and pause your animations in real-time to preview your work.
- Adjust playback speed to tune your animation timing.
- Share animations in GIF format for social media or messaging.

<img src="https://github.com/user-attachments/assets/e70be9e8-e3a8-437c-901e-e66fefad9c3f" alt="Settings Demo" width="200" height="435">
<img src="https://github.com/user-attachments/assets/9e4c32f5-432d-4fb3-9152-fa68d628c324" alt="Playback Speed UI" width="200" height="435">
<img src="https://github.com/user-attachments/assets/68df1b5a-394b-4376-bbb4-f3929bf0d152" alt="GIF Share" width="200" height="435">

### Onboarding & Common Interface
- An intuitive onboarding process introduces users to essential tools and features.
- A streamlined UI allows for easy navigation and use of color pickers, layer sheets, and animation speed settings.

<img src="https://github.com/user-attachments/assets/e91d97ce-e55a-4598-ae2f-ba00616bf147" alt="Onboarding Demo" width="200" height="435">
<img src="https://github.com/user-attachments/assets/f1e51a5e-9b89-4232-8108-6746bd7140e8" alt="Onboarding" width="200" height="435">
<img src="https://github.com/user-attachments/assets/71e808b4-430f-4bf9-a5ab-9ae2b03e0fe9" alt="Main UI" width="200" height="435">

<h2 id="menus">Contextual Menus 📋</h2>

### Layer Management (Bin & Add Layer buttons)
- **Delete All Layers:** Quickly removes all layers at once. This option is available within the layers menu, enabling users to reset their workspace efficiently.
- **Duplicate Layer:** Copies the selected layer to create an identical one in sequence, which is useful for creating incremental changes or animations based on previous frames.

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
