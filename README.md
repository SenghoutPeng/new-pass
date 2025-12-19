# Pre-Deployment Preparations

> Framework Version:
> 
> - Frontend & Backend: `Nuxt v3`
> - API: `Laravel 11`

## System Requirements

### Frontend & Backend

- Node.js >= `20.x`
- pnpm (installed with npm)

### API

- PHP >= 8.2 (with extensions: common, mysql, mbstring, xml, bcmath, curl, zip, gd, redis)
- Composer
- MariaDB/MySQL (PostgreSQL support is not guaranteed)
- Redis/Valkey (Optional)

## Setting Up Projects for Production

### Frontend & Backend

In the root directory of frontend and backend, run

```bash
pnpm i
```

If there is a warning that suggests running `pnpm approve-builds`, do so and choose to build all packages.

Edit `nuxt.config.ts`. Change all `baseUrl` to the IP address of or domain name the Laravel API server.

Finally run,

```bash
pnpm run build
```

The build can be run at `.output/server/index.mjs` (e.g. `node .output/server/index.mjs`)

Be sure to rerun `pnpm run build` and restart any Node server running the build to apply changes to the source code or config.

### API

In the root directory of frontend and backend, run

```bash
composer install
```

Make a copy of `.env.example` as `.env`. Edit the `.env` and change the database connection, `APP_URL`, `FRONTEND_URL` and any other variables based on your setup.

Continue with

```bash
php artisan key:generate
php artisan storage:link
php artisan migrate:fresh --seed
php artisan optimize
```

Be sure to rerun `php artisan optimize` every time the source code or config is modified.

## Seeded credentials

| Type         | Email                   | Password |
| ------------ | ----------------------- | -------- |
| User         | jdoe@example.com        | password |
| Organization | events@organization.com | password |
| Admin        | admin@new-pass.com      | password |
