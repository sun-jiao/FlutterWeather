import 'package:flutter/material.dart';
import 'package:flutter_weather/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import '../provider/weather_provider.dart';
import '../widgets/weather_info.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/location_error.dart';
import '../widgets/main_weather.dart';
import '../widgets/request_error.dart';
import '../widgets/weather_detail.dart';
import '../widgets/weekly_forecast.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData(context);
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherData(context, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return Consumer<WeatherProvider>(
      builder: (context, weatherProv, _) {
        if (weatherProv.isRequestError) return RequestError();
        if (weatherProv.isLocationError) return LocationError();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: WeatherSearchBar(),
          ),
          body: Column(
            children: [
              _isLoading || weatherProv.isLoading
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: themeContext.primaryColor,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Expanded(
                      child: PageView(
                        physics: BouncingScrollPhysics(),
                        controller: _pageController,
                        children: [
                          // First Page of the Page View
                          RefreshIndicator(
                            onRefresh: () async => _refreshData(context),
                            child: ListView(
                              padding: const EdgeInsets.all(10),
                              shrinkWrap: true,
                              children: [
                                MainWeather(),
                                WeatherInfo(),
                                HourlyForecast(),
                              ],
                            ),
                          ),
                          // Second Page of the Page View
                          ListView(
                            padding: const EdgeInsets.all(10),
                            children: [
                              WeeklyForecast(),
                              const SizedBox(height: 16.0),
                              WeatherDetail(),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
