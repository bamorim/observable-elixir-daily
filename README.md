# Daily

This is the sample code for my talk at Elixir Conf EU 2022.

This demo is about setting up a Phoenix application with:
- Structured Logging
- Prometheus Metrics
- Opentelemetry Tracing

This also sets up a Docker Compose environment with:
- Grafana for dashboards
- Loki for logs
- Prometheus for metrics
- Tempo for tracing
- Locust for generating load
- Caddy as a reverse proxy and as a mocked API

## Running

To have Loki working correctly inside Docker Compose, we first need to install
the Loki Docker Driver:

```bash
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

Than you can start Docker Compose with:

```bash
docker-compose up -d
```

After everythign starts properly (it can take a while to download all the images
and initialize everything), you should be able to go to
http://localhost:4002/api/reports/daily and receive something like

```json
{
  "task_descriptions": [
    "Eat",
    "Sleep",
    "Prepare ElixirConf EU 2022 Slides",
    "Repeat"
  ],
  "weather": "rainy"
}
```

Here are all the relevant ports the system will bring up

| Port | Title                  | Links and other Info                                |
| ---- | ---------------------- | --------------------------------------------------- |
| 3000 | Grafana                | [Grafana Dashboard] (admin/admin)                   |
| 4001 | Daily (Phoenix Server) | Useful if the gateway is not working for any reason |
| 4002 | Gateway (Caddy)        | Will proxy to Daily. [List Tasks], [Daily Report]   |
| 5000 | Weather Mock (Caddy)   | Returns always rainy. [Get Weather]                 |
| 5100 | Load Test (Locust)     | Useful to generate synthetic load. [Locust]         |

[Grafana Dashboard]: http://localhost:3000
[List Tasks]: http://localhost:4002/api/tasks
[Daily Report]: http://localhost:4002/api/reports/daily
[Get Weather]: http://localhost:5000/api/weather
[Locust]: http://localhost:5100/

## Further Reading

[Structured logging in Elixir using Loki](https://akoutmos.com/post/elixir-logging-loki/) by [Alex Koutmos](https://github.com/akoutmos/)