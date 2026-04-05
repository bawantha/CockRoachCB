# Palette 🎨 Journal

## 2026-04-04 - Non-functional delete button with red icon causes user confusion
**Learning:** A red `Icons.delete_outline` button with an empty `onPressed: () {}` callback is worse than no button at all. Users click it expecting deletion, get no feedback, and assume the app is broken. Disabling it (`onPressed: null`) with a tooltip clearly communicates the feature is coming soon and respects the user's expectation.
**Action:** Always disable unimplemented icon buttons (`onPressed: null`) rather than leaving an empty callback. Use `tooltip` to communicate intent even for disabled buttons.
