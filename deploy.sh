#!/bin/bash

echo "Pulling the latest changes..."
git stash
git pull origin master

echo "Activating virtual environment..."
source venv/bin/activate

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Applying migrations..."
python3 manage.py migrate

echo "Collecting static files..."
python3 manage.py collectstatic --noinput

echo "Restarting Gunicorn..."
pkill gunicorn
nohup gunicorn --bind 0.0.0.0:8000 my_tennis_club.wsgi:application > gunicorn.log 2>&1 &


echo "Deployment completed!"
