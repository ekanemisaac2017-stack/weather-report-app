from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <h1>Weather Report</h1>
    <h2>Today's Weather</h2>
    <p>🌤 Temperature: 30°C</p>
    <p>💧 Humidity: 65%</p>
    <p>💨 Wind Speed: 10 km/h</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)