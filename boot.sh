#!bin/sh
source myenv/bin/activate
exec gunicorn -b :5000 --access-logfile - --error-logfile - runserver:app