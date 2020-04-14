import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../providers/great_places.dart';
import '../screens/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var greatPlace = Provider.of<GreatPlaces>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Lokasi'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: greatPlace.fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('info lokasi belum tersedia'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => Card(
                          elevation: 10,
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    greatPlaces.items[i].image,
                                  ),
                                ),
                                title: greatPlaces.items[i].title == null
                                    ? Text("No title")
                                    : Text(greatPlaces.items[i].title),
                                subtitle: greatPlaces
                                            .items[i].location.address ==
                                        null
                                    ? Text("No address")
                                    : Text(
                                        greatPlace.items[i].location.address),
                                // onTap: () {
                                //   // go to de detail page
                                //   Navigator.of(context).pushNamed(
                                //       PlaceDetailScreen.routeName,
                                //       arguments: greatPlace.items[i].id);
                                // },
                              ),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child:  RaisedButton(onPressed: (){Navigator.of(context).pushNamed(
                                      PlaceDetailScreen.routeName,
                                      arguments: greatPlace.items[i].id);},child: Text('info lengkap'),),
                                  )
                                   
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
