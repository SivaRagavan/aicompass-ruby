# AI Compass Ruby

AI Compass Ruby is a Ruby on Rails rewrite of the AI Compass assessment platform. It keeps the private-equity company workflow intact while moving the stack to Rails + Postgres.

## Features

- PE firm sign-in with email + password
- Company assessment creation with expiring invite links
- Executive assessment flow with autosave progress tracking
- Progress tracking and results summary

## Local Development

```bash
bundle install
bin/rails db:create db:migrate
bin/rails server
```

Visit `http://localhost:3000` to access the app.

## Service Management (systemd user)

```bash
script/install.sh
script/start.sh
script/stop.sh
script/uninstall.sh
```

The service runs as `aicompass-ruby.service` and listens on port 8004. To start on boot without logging in, run `loginctl enable-linger $USER` once.

## Project Structure

- `app/controllers` — UI flows for auth, dashboard, and assessment steps
- `app/models` — Active Record models for users and assessments
- `app/lib` — Benchmark, industry, and scoring data
- `app/views` — Rails-rendered UI
