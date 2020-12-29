class StationManager {

  Map<String, String> stations = {
    '63': '하남풍산',
    '응암(하선-종착)': '응암순환',
  };

  String changeStation(String text) {
    print(stations[text]);
    return stations[text] ?? text;
  }
}