#!/bin/bash

echo "Deploy."

name: Add Branch Protections

on:
  push:
    branches:
      - main  

jobs:
  branch_protections:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Add Branch Protections
      env:
        BRANCH_NAME: "main"  
      run: |
        curl -u ${{ secrets.GITHUB_USER }}:${{ secrets.GITHUB_TOKEN }} \
          -X PUT \
          -H "Accept: application/vnd.github.v3+json" \
          https://api.github.com/repos/${{ github.repository }}/branches/${BRANCH_NAME}/protection \
          -d '{
            "required_status_checks": {
              "strict": true,
              "contexts": []
            },
            "enforce_admins": true,
            "required_pull_request_reviews": {
              "dismissal_restrictions": {
                "users": [],
                "teams": []
              },
              "dismiss_stale_reviews": true,
              "require_code_owner_reviews": true
            },
            "restrictions": null
          }'
