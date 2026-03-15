# Instagram Home Feed Clone - Flutter UI Challenge

- A pixel-perfect Instagram home feed replica with advanced interactions and clean architecture.

## 🎯 Implemented Requirements

### UI & Interactions
- **Pixel-Perfect Feed**: Exact replica of Instagram's home screen
- **Stories Tray**: Horizontal scroll with gradient rings for unseen stories
- **Image Carousel**: Multi-image posts with synchronized dot indicators
- **Pinch-to-Zoom**: Scale images with smooth return animation
- **Toggle States**: Like heart and Save bookmark with local state
- **Custom Snackbar**: Appears for unimplemented buttons (Share, Comments)

### Technical Features
- **Loading States**: 1.5s delay simulation with Shimmer effects
- **Infinite Scroll**: Auto-loads more posts when 2 away from bottom
- **Image Caching**: Network images with cached_network_image
- **Responsive Design**: flutter_screenutil for all screen sizes

## 🏗️ State Management Choice: setState

I chose **setState** as requested because:

1. **Simplicity**: Perfect for this scope - local UI state only
2. **Performance**: Optimized for simple toggle states (like/save)
3. **Readability**: Easy to follow for assessment review
4. **No overhead**: Avoids unnecessary provider/bloc boilerplate

**State Distribution:**
- `HomeScreen`: Manages posts list, loading, pagination
- `PostCard`: Handles local like/save toggles

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry + bottom nav
├── models/                   # Data models
│   ├── post_model.dart
│   ├── story_model.dart
│   └── user_model.dart
├── repositories/             # Mock data layer
│   └── post_repository.dart  # 1.5s delay simulation
├── screens/                  # UI screens
│   ├── home_screen.dart      # Main feed with infinite scroll
│   └── other_screens.dart    # Placeholder screens
└── widgets/                  # Reusable components
    ├── story_tray.dart
    ├── post_card.dart        # Carousel + interactions
    ├── pinch_zoom_image.dart # Gesture handling
    └── loading_shimmer.dart
```

🔧 Dependencies Used:
- cached_network_image: ^3.3.1  # Image caching
- flutter_screenutil: ^5.9.0     # Responsive design
- photo_view: ^0.14.0           # Pinch-to-zoom
- shimmer: ^3.0.0               # Loading effects

## Setup Instructions 🚀

1. **Clone repository**
   ```bash
   git clone https://github.com/harshitsagar/instagram_feed_clone.git

2. **Install dependencies**
   ```bash
   flutter pub get

3. **Run the App**
   ```bash
    flutter run

