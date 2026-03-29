#!/usr/bin/env bash
set -euo pipefail

# Setup Salesforce CLI and authenticate to HTS Production org
# Usage: bash setup-salesforce-cli.sh

ORG_INSTANCE_URL="https://fun-agility-769.my.salesforce.com"
ORG_ALIAS="hts-prod"

echo "=== Salesforce CLI Setup ==="

# Check if sf CLI is already installed
if command -v sf &>/dev/null; then
  echo "Salesforce CLI already installed: $(sf --version)"
else
  echo "Installing Salesforce CLI via npm..."
  npm install -g @salesforce/cli
  echo "Installed: $(sf --version)"
fi

# Authenticate to the org
echo ""
echo "=== Authenticating to HTS Production Org ==="
echo "Instance: $ORG_INSTANCE_URL"
echo "Alias: $ORG_ALIAS"
echo ""

if sf org display --target-org "$ORG_ALIAS" &>/dev/null; then
  echo "Already authenticated to $ORG_ALIAS."
  sf org display --target-org "$ORG_ALIAS"
else
  echo "Opening browser for Salesforce login..."
  sf org login web --instance-url "$ORG_INSTANCE_URL" --alias "$ORG_ALIAS"
  echo ""
  echo "Authentication successful!"
  sf org display --target-org "$ORG_ALIAS"
fi

echo ""
echo "=== Setup Complete ==="
echo "You can now use: sf org open --target-org $ORG_ALIAS"
