import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_quotes/models/quote_model.dart';
import 'package:daily_quotes/ui/views/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Daily Quotes',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.power_settings_new),
                  onPressed: () {
                    model.signOut();
                  },
                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            backgroundColor: Color(0xFFFCFBF9),
            body: _buildBody(context),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('quotes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = QuoteModel.fromFirebase(data);

    return Padding(
      key: ValueKey(record.quote),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 32,
              height: MediaQuery.of(context).size.width / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
                child: Image.network(
                  'https://blog.zoominfo.com/wp-content/uploads/2018/03/1.Blog-Quote-Template.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${record.quote}"',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          record.author,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                fontSize: 20.0,
                              ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48.0,
                              width: 48.0,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(32.0),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 4.0,
                                    blurRadius: 4.0,
                                    color: Colors.grey.shade200,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              width: 48.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(48.0),
                                child: RaisedButton(
                                  padding: EdgeInsets.all(12.0),
                                  elevation: 12.0,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Container(
                              width: 48.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(48.0),
                                child: RaisedButton(
                                  padding: EdgeInsets.all(12.0),
                                  elevation: 12.0,
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
