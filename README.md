# SINT Clean Architecture Starter (Open Neom Standard)

<p align="center">
  <a href="https://pub.dev/packages/sint"><img src="https://img.shields.io/pub/v/sint.svg?label=powered%20by%20sint&color=blue" alt="sint on pub.dev"/></a>
  <a href="https://github.com/Open-Neom/sint"><img src="https://img.shields.io/github/stars/Open-Neom/sint?style=social" alt="Star SINT on GitHub"/></a>
  <a href="https://github.com/sponsors/Open-Neom"><img src="https://img.shields.io/badge/Sponsor-GitHub%20Sponsors-ea4aaa?logo=githubsponsors" alt="GitHub Sponsors"/></a>
</p>

Minimal, zero-boilerplate **Clean Architecture** starter template for Flutter (`>=3.47.0`), built on [**SINT `^2.1.0`**](https://pub.dev/packages/sint) (**S**tate · **I**njection · **N**avigation · **T**ranslation) using the exact composition pattern that powers `30+` modular packages across [Open Neom](https://github.com/Open-Neom).

---

## Why This Architecture?

Traditional Clean Architecture in Flutter forces a trade-off between **strict domain boundaries** and **heavy boilerplate** (`build_runner`, duplicate DI registrations, or stream ceremony). With **SINT 2.1**, you get both:

1. **Contract-First DI (`Bind.putContract` & `Bind.contract`)** — Register an abstract domain contract (`AuthService`, `CounterService`) and its concrete `SintController` (`AuthController`, `CounterController`) against **one shared lazy factory**. Screens and sibling packages call `Sint.find<AuthService>()` with zero coupling to concrete controllers and `-40.8%` fewer root `Element`s.
2. **Zero-Stream `O(1)` Signals** — Fine-grained `Obx`, `.obs`, `Sint.batch`, and memoized `Sint.computed` with zero `StreamController` allocations.
3. **Global Route Guards (`globalMiddlewares`)** — Cross-cutting `AuthGuard` declared once on `SintMaterialApp`, backed by SINT's multi-level Prefix Trie router.
4. **Instant `O(1)` Localization** — Single-pass `.trParams` and runtime locale switching (`en_US` ↔ `es_ES`) via `Sint.updateLocale`.

---

## Project Structure

```text
lib/
├── domain/
│   └── interfaces/          # Pure Dart contracts (AuthService, CounterService)
├── data/
│   └── translations/        # EN / ES dictionary with @param interpolation
├── ui/
│   ├── auth/                # AuthController + LoginPage (consumes AuthService)
│   └── home/                # CounterController + HomePage (consumes contracts only)
├── app_routes.dart          # Named routes + global AuthGuard middleware
├── root_binding.dart        # Composition root (Bind.putContract & Bind.contract)
└── main.dart                # SintMaterialApp host
```

---

## Quick Start

```bash
flutter pub get
flutter test
flutter run -d chrome
```

---

## Supporting SINT & Open Neom

- Star [**Open-Neom/sint**](https://github.com/Open-Neom/sint) on GitHub & like [**`sint` on pub.dev**](https://pub.dev/packages/sint).
- Support ongoing open-source development via [**GitHub Sponsors**](https://github.com/sponsors/Open-Neom).

Released under the [MIT License](LICENSE).
