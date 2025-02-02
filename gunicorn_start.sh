#!/bin/bash
gunicorn --bind 0.0.0.0:8000 my_tennis_club.wsgi:application
