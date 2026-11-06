<p align="center">
  <img src="https://raw.githubusercontent.com/schulydev/Schuly/main/assets/app_icon.png" width="160" alt="Schuly Logo">
</p>

<h1 align="center">Schuly</h1>

<p align="center">
  <strong>The better alternative to Schulnetz</strong>
</p>

<p align="center">
  <a href="https://github.com/schulydev/Schuly/releases"><img src="https://img.shields.io/github/v/release/schulydev/Schuly?include_prereleases&color=3da8ff&label=Release" alt="Latest Release"/></a>
  <a href="https://docs.schuly.dev/getting-started/"><img src="https://img.shields.io/badge/docs-docs.schuly.dev-3da8ff" alt="Documentation"/></a>
  <a href="https://schuly.dev"><img src="https://img.shields.io/badge/site-schuly.dev-3da8ff" alt="Website"/></a>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/schulydev/SchulyWebsite/main/public/assets/schuly-start-page.png" width="32%" alt="Start" />
  <img src="https://raw.githubusercontent.com/schulydev/SchulyWebsite/main/public/assets/schuly-agenda-page.png" width="32%" alt="Agenda" />
  <img src="https://raw.githubusercontent.com/schulydev/SchulyWebsite/main/public/assets/schuly-grades-page.png" width="32%" alt="Grades" />
</p>

Your grades, exams, timetable, absences and documents in one app, for students attending a school in Switzerland. Schuly is independent and works with Schulnetz and OdA Org.

> [!IMPORTANT]
> This project is **NOT** affiliated with, endorsed by, or connected to Schulnetz or Centerboard AG in any way.

## Get it

It's not in the App Store or Google Play yet.

| On | Do this |
|---|---|
| Android | Download the `.apk` from the [latest release](https://github.com/schulydev/Schuly/releases/latest) |
| iPhone or iPad | Download the `.ipa` from the [latest release](https://github.com/schulydev/Schuly/releases/latest) and sideload it |
| Browser | Open [app.schuly.dev](https://app.schuly.dev), which needs a Schuly account |

Then follow [Get started](https://docs.schuly.dev/getting-started/) to connect your school.

## Features

- **Two ways to sign in**: a Schuly account updates in the background and notifies you about new grades. Private mode stores your school data only on your phone.
- **Several schools**: add more than one school account and switch between them.
- **Microsoft 365**: link your account and the web app also shows your mail, chats, files and notes.
- **Your own server**: use Schuly Cloud, or [run your own](https://docs.schuly.dev/self-host/) and point the app at it.

## Build it

```sh
bun run clean
bun run dev
```

You need Flutter and [bun](https://bun.sh). The dev build talks to a server on `http://localhost:5033`. The rest is in [the app docs](https://docs.schuly.dev/Schuly/).

The app screenshots for the website and store listings come from [`tools/store-screenshots`](tools/store-screenshots).

## License

[PolyForm Noncommercial 1.0.0](LICENSE)

---

<p align="center">Made with care by <a href="https://github.com/PianoNic">PianoNic</a></p>
