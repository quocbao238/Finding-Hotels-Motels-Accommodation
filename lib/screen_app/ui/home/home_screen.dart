import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/repository/user_repository.dart';
import 'package:flutter/material.dart';

class HomePageParent extends StatefulWidget {
  final UserRepository userRepository;
  HomePageParent({@required this.userRepository});
  @override
  _HomePageParentState createState() => _HomePageParentState();
}

class _HomePageParentState extends State<HomePageParent> {
  GlobalKey homeGlobalKey = GlobalKey();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    getSizeApp(context);
    return pageView(context, Size.getWidth,Size.getHeight);
  }

  WillPopScope pageView(
      BuildContext context, double getHeight, double getWidth) {
    return new WillPopScope(
      // onWillPop: _onWillPop,
      child: Scaffold(
        key: homeGlobalKey,
        body: Stack(
          children: <Widget>[
            buildTopView(getWidth, getHeight),
          ],
        ),
      ),
    );
  }

  Widget buildTopView(double getWidth, double getHeight) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: getWidth * 0.05),
          height: getHeight * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              GestureDetector(
                onTap: () {
                  _onMenuPressed(
                    context: homeGlobalKey.currentContext,
                    getHeight: getHeight,
                  );
                },
                child: Container(
                  height: getWidth * 0.1,
                  width: getWidth * 0.1,
                  child: ClipOval(
                    child: Image.network(
                      "https://avatars2.githubusercontent.com/u/51372227?s=460&u=10b00a76a16feb0edadd49f31c7d2805c2663239&v=4",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onMenuPressed({BuildContext context, double getHeight}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Color(0xFF737373),
        height: getHeight * 0.3,
        child: Container(
          child: _buildMenuWidgetBotom(context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildMenuWidgetBotom(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: ListTile(
            title: Text(
              'Help and Support',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  title: new Text('Notification'),
                  content: new Text('The feature are improving'),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Divider(height: 2.0, color: Colors.black),
          ),
        ),
        Expanded(
          flex: 4,
          child: ListTile(
            title: Text(
              'Privacy Settings',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  title: new Text('Notification'),
                  content: new Text('The feature are improving'),
                ),
              );
            },
          ),
        ),
        Expanded(
            flex: 1,
            child: Center(
              child: Divider(height: 2.0, color: Colors.black),
            )),
        Expanded(
          flex: 4,
          child: ListTile(
            title: Text(
              'Log out',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: new Text('Are you sure?'),
                  content: new Text('Do you want to Log out?'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: new Text('No'),
                    ),
                    new FlatButton(
                      onPressed: () {
                        // BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                        //     .add(LogOutEvent());
                        widget.userRepository.signOut();

                        Navigator.pop(context);
                      },
                      child: new Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Divider(height: 2.0, color: Colors.black),
          ),
        ),
      ],
    );
  }
}