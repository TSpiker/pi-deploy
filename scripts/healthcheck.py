#!/usr/bin/env python3
import psutil, socket, datetime

now = datetime.datetime.now()
print(f"📊 System Health Report at {now}")

print(f"Hostname: {socket.gethostname()}")
print(f"CPU Usage: {psutil.cpu_percent(interval=1)}%")
print(f"Memory Usage: {psutil.virtual_memory().percent}%")
print(f"Disk Usage: {psutil.disk_usage('/').percent}%")
