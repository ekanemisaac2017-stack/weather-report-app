from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Weather App</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

body{
    background:linear-gradient(135deg,#4facfe,#00f2fe);
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

.container{
    width:350px;
    background:white;
    border-radius:20px;
    padding:30px;
    box-shadow:0 15px 30px rgba(0,0,0,.2);
    text-align:center;
}

h1{
    color:#333;
    margin-bottom:20px;
}

.weather-icon{
    font-size:80px;
    margin:10px 0;
}

.temperature{
    font-size:48px;
    font-weight:bold;
    color:#333;
}

.condition{
    color:#666;
    font-size:20px;
    margin-bottom:25px;
}

.info{
    display:flex;
    justify-content:space-between;
    margin-top:20px;
}

.card{
    background:#f4f8fb;
    border-radius:15px;
    padding:15px;
    width:30%;
    box-shadow:0 5px 10px rgba(0,0,0,.08);
}

.card h3{
    font-size:14px;
    color:#666;
    margin-bottom:10px;
}

.card p{
    font-size:18px;
    font-weight:bold;
    color:#222;
}

.footer{
    margin-top:25px;
    color:#888;
    font-size:13px;
}
</style>

</head>

<body>

<div class="container">

    <h1>Weather Report</h1>

    <div class="weather-icon">
        🌤️
    </div>

    <div class="temperature">
        30°C
    </div>

    <div class="condition">
        Sunny
    </div>

    <div class="info">

        <div class="card">
            <h3>Humidity</h3>
            <p>65%</p>
        </div>

        <div class="card">
            <h3>Wind</h3>
            <p>10 km/h</p>
        </div>

        <div class="card">
            <h3>Feels Like</h3>
            <p>32°C</p>
        </div>

    </div>

    <div class="footer">
        Updated just now
    </div>

</div>

</body>
</html>
"""

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)