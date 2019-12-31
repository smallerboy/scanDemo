import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_test/navigation_util.dart';
import 'package:flutter_redux_test/test_scan.dart';
import 'package:r_scan/r_scan.dart';
import 'package:redux/redux.dart';

enum Actions{ Increment }

void main() {
  final store = Store<int>((int state, dynamic action) {
    if(action == Actions.Increment){
      return state + 1;
    }
    return state;
  }, initialState: 0);
  runApp(new MyApp(store: store));
}

class MyApp extends StatelessWidget {

  const MyApp({Key key, this.store}) : super(key: key);
  final Store<int> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: MaterialApp(
        home: MyHomePage()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  RScanResult result;

//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('test'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Text(result == null
                    ? '点击下方按钮开始扫码'
                    : '扫码结果${result.toString().split(',').join('\n')}')),
            Center(
              child: FlatButton(
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => RScanDialog()));
                  setState(() {
                    this.result = result;
                  });
                },
                child: Text('开始扫码'),
              ),
            ),


            StoreConnector<int, String>(
              converter: (store)=> store.state.toString(),
              builder: (context, count){
                return Center(child: Text('$count'));
              }
            ),
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
          ],
        ),
      ),
//      floatingActionButton: StoreConnector<int, VoidCallback>(
//        converter: (store)=>()=>store.dispatch(Actions.Increment),
//        builder: (context, cb) => FloatingActionButton(
//          onPressed: cb,
//          child: Icon(Icons.add),
//        ),
//
//      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          NavigatorUtil.pushPage(context, RScanDialog());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
