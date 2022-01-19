import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class StudentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //automaticallyImplyLeading: true,
            leading: BackButton(
          onPressed: () => Navigator.pop(context),
        )),
        body: BusMap(
            title: 'Flutter Demo Homepage',
         ));
  }
}

class BusMap extends StatefulWidget {
  const BusMap({Key? key, required this.title})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<BusMap> createState() => _BusMapState();
}

class _BusMapState extends State<BusMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(center: LatLng(51.5, -0.09), zoom: 13.0, maxZoom: 22),
      layers: [
        TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/spyinthemine/ckyi99kq100dg14no7u2ojq84/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic3B5aW50aGVtaW5lIiwiYSI6ImNreWk0Y29lYzB0bWIybnIweW1wbXFpdWEifQ.ujm-YY3zcuP1RO1ZM8YRfA",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoic3B5aW50aGVtaW5lIiwiYSI6ImNreWk0Y29lYzB0bWIybnIweW1wbXFpdWEifQ.ujm-YY3zcuP1RO1ZM8YRfA',
              'id': 'mapbox.mapbox-streets-v8'
            }
            //subdomains: ['a', 'b', 'c'],
            ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
