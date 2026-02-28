# Scroll Challenge

## Problem Statement

Build one Flutter screen that mimics a Daraz-style product listing with:
- collapsible header (banner/search bar)
- tab bar that becomes sticky when header collapses
- 2-3 product tabs (mock data allowed)
- Fakestore API integration (`https://fakestoreapi.com/`)
- login and current user profile display

> Note: The primary focus is advanced scrolling behavior and tab-indicator customization, not full Figma pixel-perfect reproduction of every screen detail.

## Engineering Challenges

- Coordinating nested scrolling behavior while keeping inner-content scroll and outer-header scroll synchronized and predictable.
- Enforcing exactly one effective vertical scroll ownership across the screen.
- Ensuring pull-to-refresh works from any tab without scroll conflict.
- Preserving vertical scroll position while switching tabs (no jump/reset).
- Supporting both tab tap and horizontal swipe without unintended vertical-scroll side effects.
- Implementing a customized tab bar/indicator with stable pinned behavior and smooth transitions.
- Separating UI, scroll/gesture ownership, and state clearly.

## Tech Stack

- Flutter (stable)
- Dart 3
- `app_pigeon` for API/auth abstraction
- `get_it` for dependency injection
- `freezed` + `freezed_annotation` for immutable/state models
- `json_serializable` + `json_annotation` for JSON mapping
- `build_runner` for code generation
- In-house packages:
  - `async_handler` (`lib/src/core/packages/async_handler`) for standardized async result/error handling.
  - `pagination_pkg` (`lib/src/core/packages/pagination_pkg`) for reusable pagination engines/controllers/cache.

## Project Structure (high level)

- `lib/src/core` -> shared infrastructure, utilities, reusable components/packages
- `lib/src/modules` -> feature modules (auth, product, cart, category, etc.)
- `lib/src/app` -> app-level routing/bootstrap glue

## Prerequisites

- Flutter SDK installed and available in PATH
- Android Studio or Xcode toolchain configured
- A connected device/emulator

## Run Locally

1. Clone the repository
```bash
git clone <your-repo-url>
cd scroll_challenge
```

2. Install dependencies
```bash
flutter pub get
```

3. Run code generation (if generated files are missing/outdated)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app
```bash
flutter run
```

## Auth Demo (FakeStore API)

- Endpoint base URL: `https://fakestoreapi.com`
- Login API: `POST /auth/login`
- Demo credentials (also prefilled in login view):
  - `username: mor_2314`
  - `password: 83r5^_`

## Build Release APK Locally

```bash
flutter build apk --release
```

Output:
- `build/app/outputs/flutter-apk/app-release.apk`

## GitHub Actions: Release APK

Workflow file:
- `.github/workflows/build-apk-main.yml`

Workflow name:
- `Build APK (main)`

Trigger:
- push to `main`
- merged PR into `main`

How to download APK artifact:
1. Open GitHub repository
2. Go to `Actions`
3. Open latest successful run of `Build APK (main)`
4. In `Artifacts`, download `app-release-apk`
5. Extract zip and use `app-release.apk`

## Branching Recommendation

For new work, create feature branches from `core-merge`:

```bash
git checkout core-merge
git pull origin core-merge
git checkout -b feature/<short-feature-name>
```

Reason:
- keeps core/shared refactors as baseline
- reduces merge conflicts across feature branches
- gives cleaner PR diffs for reviewer feedback

## Notes for Reviewers

- The codebase emphasizes modular boundaries (`core` vs `modules`).
- Shared packages/components are extracted to improve reusability and testability.
- Architecture notes included per brief:
  - horizontal swipe behavior
  - vertical scroll owner
  - trade-offs/limitations
- Auth flow currently includes:
  - login
  - get current user from persisted auth state
