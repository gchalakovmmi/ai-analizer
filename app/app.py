from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import socket
import datetime

app = FastAPI()

@app.get("/", response_class=HTMLResponse)
async def root():
    hostname = socket.gethostname()
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    html_content = f"""
    <!DOCTYPE html>
    <html>
        <head>
            <title>AI Analizer</title>
        </head>
        <body>
            <h1>Hello World</h1>
            <p>Instance Hostname: {hostname}</p>
            <p>Current Time: {now}</p>
        </body>
    </html>
    """
    return html_content

@app.get("/health")
async def health():
    return {"status": "OK"}
