# Trilium Notes Backup to Git with Docker

This is a simple backup solution for Trilium notes using docker. It will backup your notes to a git repository on a schedule.
Trilium notes already has built-in backup features, but I wanted to save my notes in their most original form on a git repository.

## Prerequisites

To get started, you'll need the following:

1. Trilium Notes
2. ETAPI Token
3. Git Repository
4. Personal Access Token
5. Docker

## Configuration

1. Generate an ETAPI token within trilium notes.
2. Create a new repository on GitHub (or any other git hosting service) for your backups.
3. Create a `.env` with the following variables:

```
# Cron schedule expression (e.g. every day at midnight)
CRON_EXPRESSION=0 0 * * *
# Maximum backup files to keep
MAX_BACKUPS=5
API_ORIGIN=your_trilium_note_origin
API_TOKEN=your_trilium_note_ETAPI_token
GIT_ORIGIN_WITH_TOKEN=https://[your_git_token]@[your_git_origin]
GIT_USER_EMAIL=your_git_user_email
GIT_USER_NAME=your_git_user_name
```

> `GIT_ORIGIN_WITH_TOKEN` must include your personal access token for authentication.

Settings > Developer settings > Personal access tokens > Generate new token

Visit github's documentation for more information on personal access tokens.

- https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
- https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps#available-scopes

## Deploy with Docker

### Docker Run

```bash
docker run -d \
  --name trilium-backup \
  --env-file .env \
  -v ~/trilium-backup:/backups \
  hypulse/trilium-backup-git
```

### Docker Compose

```yaml
version: "3"

services:
  trilium-backup:
    image: hypulse/trilium-backup-git
    container_name: trilium-backup
    volumes:
      - ~/trilium-backup:/backups
    env_file:
      - .env
```

## About

The backup process is powered by [trilium-py](https://github.com/Nriver/trilium-py). To utilize additional features of trilium-py, modify the `backup_script.py` file.
