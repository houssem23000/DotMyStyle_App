import 'package:flutter/material.dart';
import 'package:salon/feed_model.dart';
import 'package:salon/pages/product_page.dart';
import 'package:salon/pages/tab/feed_tab.dart';
import 'package:salon/pages/tab/inspiration_tab.dart';
import 'package:salon/pages/tab/salon_tab.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dot Ur Style",
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
//          bottom: TabBar(
//            labelColor: Colors.blue,
//            unselectedLabelColor: Colors.grey,
//            tabs: [
//              Tab(
//                text: "FEEDS",
//              ),
//              Tab(
//                text: "SALON",
//              ),
//              Tab(
//                text: "INSPIRE",
//              ),
//            ],
//          ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 30.0,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Ayush P Gupta",
                      style: TextStyle(color: Colors.blueGrey[700], fontWeight: FontWeight.w700, fontSize: 16.0),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey[200],
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Products'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => new ProductListPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FeedTab(),
          SalonTab(),
          InspirationTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            title: Text('Feeds'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('Salon'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            title: Text('Inspire'),
          ),
        ],
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _tabController.index = index;
            _currentTabIndex = index;
          });
        },
      ),
    );
  }
}

class FeedCard extends StatefulWidget {
  final FeedItem feedItem;

  FeedCard(this.feedItem);

  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 12.0),
                child: RichText(
                  text: new TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: widget.feedItem.description + " "),
                      new TextSpan(text: getTags(widget.feedItem.tags), style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.blue)),
                    ],
                  ),
                ),
              ),
              Image.network(widget.feedItem.feed_url),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "LIKE",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "COMMENT",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getTags(List<String> tags) {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.writeAll(tags.map((tag) => "#" + tag), " ");
    return stringBuffer.toString();
  }
}
