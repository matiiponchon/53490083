#!/bin/bash

echo "Build."

name: Run Team Scripts

on:
  workflow_run:
    workflows: ["Setup Teams and Branch Protections"]
    types:
      - completed

jobs:
  run_scripts:
    needs: setup
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Run Python Team Scripts
      run: python python_scripts.py

    - name: Run Java Team Scripts
      run: java -jar java_scripts.jar

    - name: Run C Team Scripts
      run: ./c_scripts.sh

    - name: Run Ruby Team Scripts
      run: ruby ruby_scripts.rb
