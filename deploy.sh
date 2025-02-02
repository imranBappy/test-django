#!/bin/bash

echo "Pulling the latest changes..."
git pull origin master

echo "Activating virtual environment..."
source venv/bin/activate

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Applying migrations..."
python3 manage.py migrate

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Restarting Gunicorn..."
pkill gunicorn
gunicorn --bind 0.0.0.0:8000 my_tennis_club.wsgi:application

echo "Deployment completed!"
