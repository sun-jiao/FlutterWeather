import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/weather_provider.dart';

class WeatherSearchBar extends StatefulWidget {
  @override
  _WeatherSearchBarState createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return SearchBar(
        leading: SearchBarIconButton(Icons.search_rounded),
        trailing: [
          SearchBarIconButton(Icons.location_on_rounded),
          SearchBarIconButton(Icons.settings_rounded),
        ],
        controller: _textController,
        onChanged: (value) => setState(() {}),
        shadowColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
        onSubmitted: (query) {
          if (_textController.text.isNotEmpty) {
            setState(() {
              weatherProv.searchWeather(query);
            });
          }

          _textController.clear();
          FocusScope.of(context).unfocus();
        },
      );
    });
  }
}

class SearchBarIconButton extends StatelessWidget {
  const SearchBarIconButton(this.iconData, {super.key, this.onPressed});
  final IconData iconData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: IconButton(
        icon: Icon(
          iconData,
          size: 24,
          color: Colors.grey.shade600,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
