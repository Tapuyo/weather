class WeatherModel {
  final String weather;
  final String description;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double pressure;
  final double humidity;
  final double windSpeed;
  final double windDeg;

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
  );
}
