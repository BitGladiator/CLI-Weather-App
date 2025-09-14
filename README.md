#  CLI Weather App

A simple, stylish command-line weather app written in Bash. It fetches real-time weather data for any city using the Tomorrow.io API and displays it with emoji-based summaries.

##  Features

-  Search weather by city name
-  Displays temperature, humidity, and weather conditions
-  Auto-detects coordinates via OpenStreetMap (Nominatim)
-  Emoji-enhanced output
-  Clean Bash script with no external dependencies beyond `jq` and `curl`

##  Requirements

- Bash
- `jq`
- `curl`
- A free [Tomorrow.io](https://www.tomorrow.io/) API key

##  Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/cli-weather.git
   cd cli-weather


2. Make the script executable:

   ```bash
   chmod +x weather.sh
   ```

3. Export your API key:

   ```bash
   export TOMORROW_API_KEY="your_api_key_here"
   ```

## 🌍 Usage

Run the script and enter a city name when prompted:

```bash
./weather.sh
```

Example:

```
 Enter city name: London

 Weather in London at 2025-07-08T14:00
     Partly Cloudy
     Temperature: 22.3°C
    Humidity: 68%
```

##  .gitignore Tips

It's best to keep your API key in an `.env` file and add it to `.gitignore`:

```bash
echo "TOMORROW_API_KEY=your_api_key_here" > .env
```

Then source it in your script:

```bash
source .env
```
