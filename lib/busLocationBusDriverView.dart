import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// implementing Ibrahim's Branch

//testing change from desktop pc

class BusLocationBusDriverView extends StatefulWidget {
  @override
  _BusLocationBusDriverViewState createState() =>
      _BusLocationBusDriverViewState();
}

class _BusLocationBusDriverViewState extends State<BusLocationBusDriverView> {
  Future<http.Response> fetchAlbum(query) {
    return http.get(Uri.parse(
        'https://geobus-server.ibrahimshah.repl.co/questions' + query));
  }

  String latitude = 'waiting...';
  String longitude = 'waiting...';
  String altitude = 'waiting...';
  String accuracy = 'waiting...';
  String bearing = 'waiting...';
  String speed = 'waiting...';
  String time = 'waiting...';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bus Driver View'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              locationData('Latitude: ' + latitude),
              locationData('Longitude: ' + longitude),
              locationData('Altitude: ' + altitude),
              locationData('Accuracy: ' + accuracy),
              locationData('Bearing: ' + bearing),
              locationData('Speed: ' + speed),
              locationData('Time: ' + time),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(2.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        await BackgroundLocation.setAndroidNotification(
                          title: 'Background service is running',
                          message: 'Background location in progress',
                          icon: '@mipmap/ic_launcher',
                        );
                        //await BackgroundLocation.setAndroidConfiguration(1000);
                        await BackgroundLocation.startLocationService(
                            distanceFilter: 20);
                        BackgroundLocation.getLocationUpdates((location) {
                          setState(() {
                            latitude = location.latitude.toString();
                            longitude = location.longitude.toString();
                            accuracy = location.accuracy.toString();
                            altitude = location.altitude.toString();
                            bearing = location.bearing.toString();
                            speed = location.speed.toString();
                            time = DateTime.fromMillisecondsSinceEpoch(
                                    location.time!.toInt())
                                .toString();
                          });

                          fetchAlbum(
                              "?latitude=$latitude&longitude=$longitude");

                          /*print('''\n
                        Latitude:  $latitude
                        Longitude: $longitude
                        Altitude: $altitude
                        Accuracy: $accuracy
                        Bearing:  $bearing
                        Speed: $speed
                        Time: $time
                      ''');*/
                        });
                      },
                      child: const Text('Start Location Service'),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(2.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        BackgroundLocation.stopLocationService();
                      },
                      child: const Text('Stop Location Service'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  void getCurrentLocation() {
    BackgroundLocation().getCurrentLocation().then((location) {
      print('This is current Location ' + location.toMap().toString());
    });
  }

  @override
  void dispose() {
    BackgroundLocation.stopLocationService();
    super.dispose();
  }
}
