class WeatherModel {
  final String weather;
  final String description;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final String name;

  WeatherModel(
      this.weather,
      this.description,
      this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.windDeg,
      this.name
  );
}
