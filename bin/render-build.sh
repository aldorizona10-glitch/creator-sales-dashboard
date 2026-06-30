#!/usr/bin/env bash
# Exit on error
set -o errexit

# Build steps for Render.com deployment
# Runs in the build environment (ephemeral) before the app starts

echo "==> Installing dependencies..."
bundle install

echo "==> Precompiling assets..."
bin/rails assets:precompile

echo "==> Cleaning assets..."
bin/rails assets:clean

echo "==> Done. Ready to start."