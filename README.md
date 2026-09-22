# LifeDrop - Emergency Blood Donor & Blood Bank Network 🩸

LifeDrop is a modern, responsive Single Page Application (SPA) designed for rapid blood donor matching, real-time emergency SOS broadcasts, and verified regional blood bank discovery.

---

## ✨ Features

- **Custom Interactive Dropdowns**: Bespoke blood group selectors with compatibility badges and zero native select tags.
- **Floating SOS Emergency Trigger (FAB)**: Sticky emergency button with ripple pulse animations.
- **Interactive Live Map (Leaflet & OpenStreetMap)**: Geospatial visualization of active SOS alerts, accredited blood banks, and verified voluntary donors with GPS localization.
- **Urgency Selector Cards**: Categorized visual selector cards (Critical < 2h, High < 6h, Standard < 24h).
- **Supabase Cloud Sync & Realtime**: PostgreSQL backend integration (`donors`, `sos_requests`, `blood_banks`) with real-time broadcast listeners.
- **Blood Compatibility Matrix**: Interactive cross-matching chart for universal donors and recipients.
- **Verified Blood Banks Directory**: Hospital facilities with stock availability indicators and direct call / Google Maps integration.

---

## 🚀 Getting Started

1. Open `index.html` directly in any modern browser.
2. To enable cloud synchronization, run the SQL queries in [`supabase_schema.sql`](./supabase_schema.sql) in your [Supabase SQL Editor](https://supabase.com/dashboard).

---

## 🛠️ Tech Stack

- **Frontend**: HTML5, CSS3 (Modern Flexbox/Grid), Vanilla JavaScript (ES6+)
- **Icons & Fonts**: Font Awesome 6, Google Fonts (*Plus Jakarta Sans*, *Outfit*)
- **Maps**: Leaflet.js, OpenStreetMap (CartoDB Positron)
- **Backend / Database**: Supabase (PostgreSQL, Realtime channels, Row-Level Security)
