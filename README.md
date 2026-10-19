# sayasvvportfolio.space

Portfolio website of Sayas V V, freelance web & app developer, Malappuram, Kerala.

## How it deploys
Every push to `main` runs `.github/workflows/deploy.yml`, which copies the site to the AWS server over SSH and publishes it to the Nginx web folder.

Repository secrets needed (Settings → Secrets and variables → Actions):

| Secret | Value |
|---|---|
| `SSH_HOST` | Server public IP (or Elastic IP) |
| `SSH_USER` | `ubuntu` |
| `SSH_KEY` | Full contents of the server's `.pem` key file |
| `WEBROOT` | Nginx web folder, e.g. `/var/www/html` |

## Pages
- `/` — home
- `/web-design-malappuram/`
- `/app-development-kerala/`
- `/ai-video-creation-kerala/`

When adding a page, also add it to `sitemap.xml`.
