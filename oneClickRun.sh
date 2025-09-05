#!/bin/bash

echo "Do you want to run the scraper? (It may take a minute) [y/N]"
read -r run_scraper

# Function to run a service and close if successful
run_service() {
  gnome-terminal -- bash -c "
    cd $1 &&
    npm install &&
    npm start;
    if [ $? -eq 0 ]; then
      echo '$1 exited successfully. Closing...';
      sleep 2
      exit
    else
      echo '$1 encountered an error. Terminal will remain open.';
      exec bash
    fi"
}

# Conditionally run scraper
if [[ "$run_scraper" == "y" || "$run_scraper" == "Y" ]]; then
  run_service "scraper"
fi

# Run frontend and backend
run_service "frontend"
run_service "backend"