# MarsRoverServer.jl

Example API server using NASA's Open APIs.
Powered by JuliaHub.

Uses Mars Rover Photos to produce image links.

## Mars Rover Photos

> `GET https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY`

## Query Parameters

| Parameter | Type | Default | Description |
| --------- | ---- | ------- | ----------- |
| `sol` | int | none | sol (ranges from 0 to max found in endpoint) |
| `camera` | string | all | see table above for abbreviations |
| `page` | int | 1 | 25 items per page returned |
| `api_key` | string | DEMO_KEY | api.nasa.gov key for expanded usage |

## API Key

For extended use, get your own NASA API key and save its value to environment variable `SECRET_NASA_API_KEY` when launching this application.