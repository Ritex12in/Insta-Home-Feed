# 📸 Instagram Home Feed

A pixel-perfect replication of the Instagram Home Feed.

---

## 🎥 Demo

> https://drive.google.com/file/d/1-nFcJO_pCpqFHgfkhvq17j42kEXGU1aA/view?usp=sharing

---

## ✨ What's Implemented

### UI
- Native splash screen via `flutter_native_splash`
- Instagram top bar — `insta_top_vector.svg` logo, notifications, messages icons
- Horizontal stories tray with avatar gradient ring + username labels
- Feed posts — single image (`9:16`) and carousel (multi-image, `1:1`)
- Carousel with synchronized `AnimatedContainer` dot indicators + `2/4` slide counter badge
- Ad posts with `3:4` aspect ratio and a green **Sign-Up** CTA strip
- "Suggested for you" label + Follow button on post headers
- **Suggested For You** horizontal section injected between page 1 and paginated posts
- "Liked by" row + bold caption + grey time-ago text under every post
- Interest prompt widget between posts

### Interactions
- ❤️ **Like** — toggles `heart.svg` ↔ `heart_filled.svg`, turns red, increments count locally
- 🔖 **Bookmark** — toggles `bookmark.svg` ↔ `bookmark_filled.svg` locally
- 💬 **Comment**, 🔁 **Repost**, 📤 **Share** — floating `SnackBar` (dark `#262626`, rounded, dismisses after 2s)
- **Pinch-to-Zoom** — 2-finger pinch reveals a full-screen dark scrim overlay with the zoomed image; releasing fingers dismisses it

### Data & Performance
- **Shimmer loading state** on cold start — custom, no third-party package
- **1.5-second simulated latency** in `InstaDataSource` to demonstrate the shimmer
- **Infinite scroll pagination** — `loadMore()` fires when scroll is within 200px of bottom; `_isPaginationCalled` guard prevents duplicate requests
- All images loaded from **public HTTPS URLs** — nothing bundled in assets
- `CachedNetworkImage` (`^3.3.1`) for memory + disk caching; dark `#262626` placeholder on load/error

---

## 🏗️ Project Structure

The project follows a clean **3-layer architecture**: `data → domain → presentation`.
```
lib/
├── core/
│   ├── providers/
│   │   └── app_providers.dart          # homeNotifierProvider (Riverpod)
│   └── widgets/
│       ├── instagram_top_bar.dart      # AppBar — logo + icons
│       └── instagram_bottom_nav.dart   # Bottom nav
│
├── data/
│   ├── datasource/
│   │   └── insta_datasource.dart       # Mock data + 1.5s latency simulation
│   └── domain/
│       └── repository/
│           └── home_repository_impl.dart
│
├── domain/
│   ├── model/
│   │   └── home_page_state.dart        # HomePageState (posts, stories, suggestedUsers, page)
│   └── repository/
│       └── home_repository.dart        # Abstract repository interface
│
└── presentation/
    └── pages/
        └── home/
            ├── models/
            │   ├── feed_item.dart
            │   ├── feed_post_model.dart
            │   ├── story_model.dart
            │   ├── suggested_user_model.dart
            │   └── user_model.dart
            ├── screen/
            │   └── home_screen.dart
            ├── viewmodel/
            │   └── home_notifier.dart          # AsyncNotifier — load, loadMore
            └── widgets/
                ├── feed_post.dart
                ├── home_screen_shimmer.dart
                ├── interest_prompt.dart
                ├── pinch_zoom_overlay.dart
                ├── post_actions_bar.dart
                ├── post_header.dart
                ├── stories_bar.dart
                └── suggested_for_you_section.dart

assets/
├── images/
│   └── splash_icon.png
└── vectors/
    ├── beacon.svg            # Comment
    ├── bookmark.svg / bookmark_filled.svg
    ├── heart.svg / heart_filled.svg
    ├── home.svg
    ├── insta_top_vector.svg  # Instagram wordmark
    ├── play_alt.svg
    ├── repeat.svg            # Repost
    ├── search.svg
    └── share.svg
```

---

## 🧠 State Management — Riverpod `^3.2.0`

**Why Riverpod?**

- `AsyncNotifier<HomePageState>` gives a compile-safe `loading / data / error` tri-state — maps directly to `HomeScreenShimmer` / feed / error text in `state.when()`
- `HomePageState` (posts, stories, suggestedUsers, page) lives entirely in the notifier — `HomeScreen` is a pure `ConsumerStatefulWidget` with no business logic
- `loadMore()` appends the next page and bumps `page`; the `HomeScreen` sliver checks `data.page > 1` to inject the paginated posts sliver
- Repository is injected via provider — the UI never touches `InstaDataSource` directly

---

## 🔍 Technical Notes

### Pinch-to-Zoom (`pinch_zoom_overlay.dart`)
- `onScaleStart` checks `pointerCount >= 2` so single-finger scrolling is never intercepted
- `OverlayEntry` inserted into the root `Overlay` on pinch — renders above everything including the bottom nav
- Zoom + offset state flows through `ValueNotifier<_ZoomState>` → `ValueListenableBuilder` in the overlay — the overlay has **zero reference** to the parent `State` object
- `dispose()` only calls `_overlayEntry?.remove()` — no `setState` — fixes the `_lifecycleState != defunct` crash when a post unmounts mid-zoom

### Shimmer (`home_screen_shimmer.dart`)
- One `AnimationController` (1400ms repeat) drives a `LinearGradient` sweep (`#1A1A1A → #3A3A3A`) across every box in sync
- Skeleton matches the real layout: stories circles → post header → full-height image block → action icons → caption lines
- `NeverScrollableScrollPhysics` prevents interaction during load

### Carousel (`feed_post.dart`)
- `PageView.builder` + `PageController` per post instance
- `AnimatedContainer` dots (200ms) driven by `onPageChanged`
- `2/4` counter badge (top-right `Positioned`, semi-transparent black pill)
- Single-finger swipe = page; two-finger pinch = zoom — no conflict

### Count Formatting (`post_actions_bar.dart`)
`_formatCount()` converts raw ints: `1200 → 1.2K`, `4500000 → 4.5M`

---

## 🚀 Running the Project

**Prerequisites:** Flutter `>=3.0.0` · Dart `>=3.0.0`
```bash
git clone https://github.com/Ritex12in/Insta-Home-Feed.git
cd Insta-Home-Feed
flutter pub get
flutter run
```

**Release APK:**
```bash
flutter build apk --release
```

---

## 📦 Dependencies

| Package                 | Version | Purpose                              |
|-------------------------|---------|--------------------------------------|
| `flutter_riverpod`      | ^3.2.0  | State management (`AsyncNotifier`)   |
| `cached_network_image`  | ^3.3.1  | Network image caching + placeholders |
| `flutter_svg`           | ^2.2.1  | SVG icon rendering                   |
| `flutter_native_splash` | ^2.4.6  | Native splash screen                 |
| `cupertino_icons`       | ^1.0.8  | iOS-style icons                      |