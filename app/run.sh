#!/bin/sh
pip install -r requirements.txt
nohup uvicorn app:app --host 0.0.0.0 --port 8000 > /dev/null 2>&1 &
