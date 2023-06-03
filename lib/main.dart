import 'package:flutter/material.dart';
import 'package:moengage_flutter/model/inapp/click_data.dart';
import 'package:moengage_flutter/model/inapp/inapp_data.dart';
import 'package:moengage_flutter/model/inapp/self_handled_data.dart';
import 'package:moengage_flutter/model/push/push_campaign_data.dart';
import 'package:moengage_flutter/model/push/push_token_data.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/properties.dart';
import 'package:moengage_geofence/moe_geofence.dart';
import 'package:moengage_inbox/inbox_data.dart';
import 'package:moengage_inbox/moengage_inbox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MoEngageFlutter _moengagePlugin = MoEngageFlutter("U8RR6TSZPEM5EWFBCZBNJVIJ");
  final MoEngageInbox _moEngageInbox = MoEngageInbox("U8RR6TSZPEM5EWFBCZBNJVIJ");
  final MoEngageGeofence _moEngageGeofence = MoEngageGeofence("U8RR6TSZPEM5EWFBCZBNJVIJ");

  @override
  void initState() {
    super.initState();

    _moengagePlugin.setPushClickCallbackHandler(_onPushClick);
    _moengagePlugin.setInAppShownCallbackHandler(_onInAppShown);
    _moengagePlugin.setInAppDismissedCallbackHandler(_onInAppDismiss);
    _moengagePlugin.setInAppClickHandler(_onInAppClick);
    _moengagePlugin.setSelfHandledInAppHandler(_onInAppSelfHandle);
    _moengagePlugin.setPushTokenCallbackHandler(_onPushTokenGenerated);

    _moengagePlugin.initialise();
    //_moengagePlugin.enableSDKLogs();
    //_moengagePlugin.setCurrentContext(["My_context", "tundndn"]);

    //_moengagePlugin.showInApp();

    //_moengagePlugin.resetCurrentContext();

    //android 13 push permission
    _moengagePlugin.requestPushPermissionAndroid();
    _moEngageGeofence.startGeofenceMonitoring();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Demo App"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.setUniqueId("8708153354");
                  },
                  child: Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.logout();
                  },
                  child: Text("Logout"),
                ),
                ElevatedButton(
                  onPressed: () {
                    //.optOutDataTracking(true);
                  },
                  child: Text("optOutTracking"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.setUserName("Vipin Kumar");
                    _moengagePlugin.setFirstName("Vipin");
                    _moengagePlugin.setLastName("Kumar");
                    _moengagePlugin.setEmail("vicky7230@gmail.com");
                    _moengagePlugin.setPhoneNumber("8708153354");
                    //_moengagePlugin.setGender(MoEGender
                    //    .male); // Supported values also include MoEGender.female OR MoEGender.other
                    //_moengagePlugin.setLocation(new MoEGeoLocation(23.1,
                    //    21.2)); // Pass coordinates with MoEGeoLocation instance
                    _moengagePlugin.setBirthDate(
                        "2000-12-02T08:26:21.170Z"); // date format - ` yyyy-MM-dd'T'HH:mm:ss.fff'Z'`
                  },
                  child: Text("Track attributes"),
                ),
                ElevatedButton(
                  onPressed: () {
                    var properties = MoEProperties();
                    properties
                        .addAttribute("test_string", "Apple")
                        .addAttribute("test_int", 789)
                        .addAttribute("test_bool", false)
                        .addAttribute("attr_double", 12.32)
                        //.addAttribute(
                        //    "attr_location", new MoEGeoLocation(12.1, 77.18))
                        .addAttribute("attr_array", [
                      "item1",
                      "item2",
                      "item3"
                    ]).addISODateTime("attr_date", "2021-08-18T09:57:21.170Z");

                    _moengagePlugin.trackEvent(
                        'Flutter_test_Event', properties);
                  },
                  child: Text("Track Events"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.showInApp();
                  },
                  child: Text("Show InApp"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.getSelfHandledInApp();
                  },
                  child: Text("Show Self Handled InApp"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    //int count = await _moEngageInbox.getUnClickedCount();
                    //print("Unclicked Message Count " + count.toString());
                  },
                  child: Text("Get Unclicked Message Count"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    InboxData? data = await _moEngageInbox.fetchAllMessages();
                    print("messages: " + data.toString());
                    for (final message in data!.messages) {
                      print(message.toString());
                    }
                  },
                  child: Text("Fetch All Messages"),
                ),
                ElevatedButton(
                  onPressed: ()  {
                   //_moengagePlugin.optOutPushTracking(false);
                  },
                  child: Text("OPT OUT Push"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _onPushClick(PushCampaignData message) {
    print("_onPushClick() : Payload " + message.toString());
  }

  void _onPushTokenGenerated(PushTokenData pushToken) {
    print(
        "Main : _onPushTokenGenerated() : This is callback on push token generated from native to flutter: PushToken: " +
            pushToken.toString());
  }

  void _onInAppClick(ClickData message) {
    print("_onInAppClick() : Payload " + message.toString());
  }

  void _onInAppShown(InAppData message) {
    print("_onInAppShown() : Payload " + message.toString());
  }

  void _onInAppDismiss(InAppData message) {
    print("_onInAppDismiss() : Payload " + message.toString());
  }

  void _onInAppCustomAction(InAppData message) {
    print("_onInAppCustomAction() : Payload " + message.toString());
  }

  void _onInAppSelfHandle(SelfHandledCampaignData message) {
    print("_onInAppSelfHandle() : Payload " + message.toString());
    _moengagePlugin.selfHandledShown(message);
    _moengagePlugin.selfHandledDismissed(message);
  }
}
