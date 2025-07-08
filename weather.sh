#!/bin/bash


# CONFIG
API_KEY="${TOMORROW_API_KEY}"  
UNITS="metric"
FIELDS="temperature,humidity,weatherCode"
TIMESTEP="1h"  # Use hourly since minutely may not be available
API_URL="https://api.tomorrow.io/v4/timelines"

#CHECK DEPENDENCIES
if ! command -v jq >/dev/null; then
    echo "Please install 'jq': sudo apt install jq"
    exit 1
fi

#GET CITY
read -p "Enter city name: " CITY

#GET COORDINATES FROM NOMINATIM (OpenStreetMap)
coords=$(curl -s "https://nominatim.openstreetmap.org/search?q=${CITY// /+}&format=json&limit=1")

LAT=$(echo "$coords" | jq -r '.[0].lat')
LON=$(echo "$coords" | jq -r '.[0].lon')

if [[ -z "$LAT" || -z "$LON" || "$LAT" == "null" ]]; then
    echo "Could not find coordinates for '$CITY'."
    exit 1
fi

#FETCH WEATHER
response=$(curl -s "$API_URL?location=$LAT,$LON&fields=$FIELDS&units=$UNITS&timesteps=$TIMESTEP&apikey=$API_KEY")

# DEBUG: Uncomment to inspect full response
# echo "$response" | jq .

#PARSE WEATHER
temperature=$(echo "$response" | jq -r '.data.timelines[0].intervals[0].values.temperature')
humidity=$(echo "$response" | jq -r '.data.timelines[0].intervals[0].values.humidity')
code=$(echo "$response" | jq -r '.data.timelines[0].intervals[0].values.weatherCode')
time=$(echo "$response" | jq -r '.data.timelines[0].intervals[0].startTime')

#WEATHER EMOJI MAPPING
case $code in
  1000) icon="☀️  Clear";;
  1100) icon="🌤️  Mostly Clear";;
  1101) icon="⛅  Partly Cloudy";;
  1102) icon="🌥️  Mostly Cloudy";;
  1001) icon="☁️  Cloudy";;
  4000|4200) icon="🌦️  Light Rain";;
  4201) icon="🌧️  Heavy Rain";;
  *) icon="Unknown";;
esac

#DISPLAY OUTPUT
echo ""
echo -e "City: \e[1m$CITY\e[0m\n  Time: ${time%:*}"
echo "   $icon"
echo "   🌡️  Temperature: ${temperature}°C"
echo "   💧 Humidity: ${humidity}%"
echo ""

