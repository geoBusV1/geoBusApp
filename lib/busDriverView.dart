import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// implementing Ibrahim's Branch

//testing change from desktop pc

class BusDriverView extends StatefulWidget {
  @override
  _BusDriverViewState createState() =>
      _BusDriverViewState();
}

class _BusDriverViewState extends State<BusDriverView> {
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
          //automaticallyImplyLeading: true,
          leading: BackButton(onPressed: () => Navigator.pop(context),),
          title: const Text('Bus Driver Homepage'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              locationData('Latitude: ' + latitude),
              locationData('Longitude: ' + longitude),
              locationData('Altitude: ' + altitude),
              locationData('Accuracy: ' + accuracy),
              locationData('Bearing: ' + bearing),
              locationData('Speed: ' + speed),
              locationData('Time: ' + time),
              const SizedBox(height: 30),
              ElevatedButton(
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

                      fetchAlbum("?latitude=$latitude&longitude=$longitude");

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
                  child: Text('Start Location Service')),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    BackgroundLocation.stopLocationService();
                  },
                  child: Text('Stop Location Service')),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    getCurrentLocation();
                  },
                  child: Text('Get Current Location')),
            ],
        ),
        )
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