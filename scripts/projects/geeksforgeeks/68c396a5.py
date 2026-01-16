import requests

def forecast() -> str:
    city = input("City: ")
    geo_url = "https://geocoding-api.open-meteo.com/v1/search"
    geo_params = {"name": city, "count": 1}

    geo_response = requests.get(geo_url, geo_params).json()

    if "results" in geo_response:
        latitude = geo_response["results"][0]["latitude"]
        longitude = geo_response["results"][0]["longitude"]

        weather_url = "https://api.open-meteo.com/v1/forecast"
        weather_params = {
            "latitude": latitude,
            "longitude": longitude,
            "current": [
                "temperature_2m",
                "windspeed_10m",
                "winddirection_10m",
                "precipitation",
                "relativehumidity_2m"
            ]
        }
        print(f'\nCity: {city!r} (Confirmed.)')

        weather_response = requests.get(weather_url, weather_params).json()
        current = weather_response["current"]

        print("Temperature:", current["temperature_2m"], "°C")
        print("Windspeed:", current["windspeed_10m"], "km/h")
        print("Wind direction:", current["winddirection_10m"], "°")
        print("Precipitation:", current["precipitation"], "mm")
        print("Humidity:", current["relativehumidity_2m"], "%")
    else:
        print("City not found.")
        
if __name__ == "__main__":
    forecast()