from locust import HttpUser, task, between
import random

class APIUser(HttpUser):
    wait_time = between(0.5, 1.5)
    
    @task(2)
    def get_daily_report(self):
        self.client.get("/api/reports/daily")

    @task(3)
    def list_tasks(self):
        self.client.get("/api/tasks")

    @task(5)
    def get_task(self):
        id = abs(round(random.gauss(3,5/3)))
        self.client.get(f"/api/tasks/{id}", name="/api/tasks/{id}")