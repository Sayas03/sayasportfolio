#!/usr/bin/env bash
# Run on the server after pushing to GitHub:  bash ~/sayasportfolio/deploy.sh
# Pulls the latest site, publishes it to Nginx, and notifies Bing/IndexNow search engines.
set -euo pipefail
REPO="$HOME/sayasportfolio"
WEBROOT="/var/www/html"
SITE="https://www.sayasvvportfolio.space"
KEY="2ad30380cc25ef856a8fbc75afe46bb1"

cd "$REPO"
git fetch origin
git reset --hard origin/main

sudo rsync -a --exclude '.git' --exclude '.github' --exclude 'README.md' --exclude 'deploy.sh' "$REPO/" "$WEBROOT/"
sudo chown -R www-data:www-data "$WEBROOT"
echo "Published to $WEBROOT"

# Tell IndexNow engines (Bing, Yandex, Seznam, Naver) that these pages changed
URLS=$(grep -o '<loc>[^<]*</loc>' sitemap.xml | sed 's/<[^>]*>//g' | sed 's/.*/"&"/' | paste -sd, -)
curl -s -o /dev/null -w "IndexNow response: %{http_code}\n" -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{\"host\":\"www.sayasvvportfolio.space\",\"key\":\"$KEY\",\"keyLocation\":\"$SITE/$KEY.txt\",\"urlList\":[$URLS]}" || true
