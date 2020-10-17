import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnesstrainer/models/exercise_logs.dart';
import 'package:myfitnesstrainer/models/set_logs.dart';
import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/models/workout_logs.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/screens/student/timerscreen.dart';
import 'package:myfitnesstrainer/screens/student/workout_summary.dart';
import 'package:myfitnesstrainer/viewmodel/workout_helper_old_logs.dart';
import 'package:vibration/vibration.dart';
import 'dart:math' as math;
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutHelper extends StatefulWidget {
  final Workout workout;
  WorkoutHelper(this.workout);
  _WorkoutHelperState createState() => _WorkoutHelperState();
}

class _WorkoutHelperState extends State<WorkoutHelper>
    with TickerProviderStateMixin {
  List<TextEditingController> _repControllers = [];
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _weightControllers = [];
  PageController pageController;
  PageController verticalController;
  bool first = true;
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Pes etme!'),
            content: new Text('Bitirmeden çıkmak istediğinize emin misiniz?'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("HAYIR"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("EVET"),
              ),
            ],
          ),
        ) ??
        false;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController controller;
  int currentIndex = 0;
  List<ExerciseLogs> _exerciseLogs = [];

  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    /// Attach a listener which will update the state and refresh the page index
    pageController = PageController();

    pageController.addListener(() {
      if (pageController.page.round() != currentIndex) {
        setState(() {
          currentIndex = pageController.page.round();
        });
      }
      controller.addListener(() {
        if (controller.isCompleted) {
          Vibration.vibrate(
            pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500],
            intensities: [128, 255, 64, 255],
          );
        }
      });
    });
    verticalController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    controller.dispose();

    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (first) {
      for (var i = 0; i < widget.workout.exerciseTargetsList.length; i++) {
        _repControllers.add(TextEditingController(
            text: widget.workout.exerciseTargetsList[i].maxRep.toString()));
        _weightControllers.add(TextEditingController());
        _exerciseLogs.add(ExerciseLogs(
            exerciseName: widget.workout.exerciseTargetsList[i].exercise.name,
            setLogs: []));
      }
      first = false;
    }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: pageController,
                  itemBuilder: (context, position) {
                    return Scaffold(
                        appBar: AppBar(
                          leading: InkWell(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              final value = await showDialog(
                                context: context,
                                builder: (context) => new AlertDialog(
                                  title: new Text('Pes etme!'),
                                  content: new Text(
                                      'Bitirmeden çıkmak istediğinize emin misiniz?'),
                                  actions: <Widget>[
                                    new GestureDetector(
                                      onTap: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text("HAYIR"),
                                    ),
                                    SizedBox(height: 16),
                                    new GestureDetector(
                                      onTap: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text("EVET"),
                                    ),
                                  ],
                                ),
                              );
                              if (value == true) {
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                          title: Text(widget.workout
                              .exerciseTargetsList[position].exercise.name),
                        ),
                        body: PageView(
                          controller: verticalController,
                          scrollDirection: Axis.vertical,
                          children: [
                            buildExerciseVideoPage(position),
                            buildWorkoutInputPage(position),
                            buildLastWorkoutPage(position)
                          ],
                        ));
                  },
                  itemCount: widget.workout.exerciseTargetsList.length),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.20,
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child) {
                                return CustomPaint(
                                    painter: TimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.white,
                                  color: Colors.blue,
                                ));
                              },
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AnimatedBuilder(
                                    animation: controller,
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return Text(
                                        timerString,
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Form(
                    autovalidate: true,
                    key: _formKey,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.25,
                        color: Colors.white,
                        child: _exerciseLogs[currentIndex].setLogs.length ==
                                    widget
                                        .workout
                                        .exerciseTargetsList[currentIndex]
                                        .setCount &&
                                currentIndex !=
                                    widget.workout.exerciseTargetsList.length -
                                        1
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Egzersizi tamamladınız",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: RaisedButton(
                                        onPressed: () {
                                          pageController.nextPage(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease);
                                        },
                                        child: Text("SIRADAKI EGZERSİZ",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : _exerciseLogs[currentIndex].setLogs.length ==
                                        widget
                                            .workout
                                            .exerciseTargetsList[currentIndex]
                                            .setCount &&
                                    currentIndex ==
                                        widget.workout.exerciseTargetsList
                                                .length -
                                            1
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Antrenmanı tamamladınız!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: RaisedButton(
                                              onPressed: () {
                                                WorkoutLogs _workoutLogs =
                                                    WorkoutLogs();
                                                _workoutLogs.exerciseLogs =
                                                    _exerciseLogs;
                                                _workoutLogs.date =
                                                    DateTime.now();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WorkoutSummary(
                                                              _workoutLogs,
                                                              widget.workout)),
                                                );
                                              },
                                              child: Text("ANTRENMANI BİTİR",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : widget
                                        .workout
                                        .exerciseTargetsList[currentIndex]
                                        .repBased
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller:
                                                      _weightControllers[
                                                          currentIndex],
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      suffixText: "kg"),
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller: _repControllers[
                                                      currentIndex],
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      suffixIconConstraints:
                                                          BoxConstraints(
                                                              minWidth: 0,
                                                              minHeight: 0),
                                                      isDense: true,
                                                      suffixText: "tekrar"),
                                                  onChanged: (value) {},
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: RaisedButton(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              onPressed: () {
                                                if (_repControllers[
                                                            currentIndex]
                                                        .text ==
                                                    "") {
                                                  _scaffoldKey.currentState
                                                      .hideCurrentSnackBar();

                                                  _scaffoldKey.currentState
                                                      .showSnackBar(SnackBar(
                                                    content: new Text(
                                                        'Tekrar boş olamaz'),
                                                    duration: new Duration(
                                                        seconds: 3),
                                                  ));
                                                } else {
                                                  if (widget
                                                          .workout
                                                          .exerciseTargetsList[
                                                              currentIndex]
                                                          .setCount >
                                                      _exerciseLogs[
                                                              currentIndex]
                                                          .setLogs
                                                          .length) {
                                                    setState(() {
                                                      controller.dispose();
                                                      _exerciseLogs[
                                                              currentIndex]
                                                          .setLogs
                                                          .add(SetLogs(
                                                              weight: int.tryParse(
                                                                      _weightControllers[
                                                                              currentIndex]
                                                                          .text) ??
                                                                  0,
                                                              reps: int.parse(
                                                                  _repControllers[
                                                                          currentIndex]
                                                                      .text)));
                                                      controller = AnimationController(
                                                          vsync: this,
                                                          duration: Duration(
                                                              seconds: widget
                                                                  .workout
                                                                  .exerciseTargetsList[
                                                                      currentIndex]
                                                                  .rest));
                                                    });
                                                    controller.reverse(
                                                        from: controller
                                                                    .value ==
                                                                0.0
                                                            ? 1.0
                                                            : controller.value);
                                                  }
                                                }

                                                //   if(currentIndex==0)
                                              },
                                              child: Text("SETİ KAYDET",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller:
                                                      _weightControllers[
                                                          currentIndex],
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      suffixText: "kg"),
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller: _repControllers[
                                                      currentIndex],
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      suffixIconConstraints:
                                                          BoxConstraints(
                                                              minWidth: 0,
                                                              minHeight: 0),
                                                      isDense: true,
                                                      suffixText: "saniye"),
                                                  onChanged: (value) {},
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: RaisedButton(
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    int value =
                                                        await showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          TimerScreen(),
                                                    );
                                                    _repControllers[
                                                                currentIndex]
                                                            .text =
                                                        value.toString();
                                                  },
                                                  child: Text(
                                                    "ZAMANLAYICI BAŞLAT",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: RaisedButton(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  onPressed: () {
                                                    if (_repControllers[
                                                                currentIndex]
                                                            .text ==
                                                        "") {
                                                      _scaffoldKey.currentState
                                                          .hideCurrentSnackBar();

                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: new Text(
                                                            'Saniye boş olamaz'),
                                                        duration: new Duration(
                                                            seconds: 3),
                                                      ));
                                                    } else {
                                                      if (widget
                                                              .workout
                                                              .exerciseTargetsList[
                                                                  currentIndex]
                                                              .setCount >
                                                          _exerciseLogs[
                                                                  currentIndex]
                                                              .setLogs
                                                              .length) {
                                                        setState(() {
                                                          controller.dispose();
                                                          _exerciseLogs[currentIndex].setLogs.add(SetLogs(
                                                              weight: int.tryParse(
                                                                      _weightControllers[
                                                                              currentIndex]
                                                                          .text) ??
                                                                  0,
                                                              duration: int.parse(
                                                                  _repControllers[
                                                                          currentIndex]
                                                                      .text)));

                                                          controller = AnimationController(
                                                              vsync: this,
                                                              duration: Duration(
                                                                  seconds: widget
                                                                      .workout
                                                                      .exerciseTargetsList[
                                                                          currentIndex]
                                                                      .rest));
                                                        });
                                                        controller.reverse(
                                                            from: controller
                                                                        .value ==
                                                                    0.0
                                                                ? 1.0
                                                                : controller
                                                                    .value);
                                                      }
                                                    }

                                                    //   if(currentIndex==0)
                                                  },
                                                  child: Text("SETİ KAYDET",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String calculateDaysAgo(DateTime time) {
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    final now = new DateTime.now();
    final difference = now.difference(time);
    return timeago.format(DateTime.now().subtract(difference), locale: 'tr');
  }

  SingleChildScrollView buildWorkoutInputPage(int position) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Bugün",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      widget.workout.exerciseTargetsList[position].setCount,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        widget.workout.exerciseTargetsList[position].repBased
                            ? ListTile(
                                title: _exerciseLogs[position].setLogs.length > index &&
                                        _exerciseLogs[position].setLogs[index].weight !=
                                            0
                                    ? Text("Set " +
                                        (index + 1).toString() +
                                        ", " +
                                        _exerciseLogs[position]
                                            .setLogs[index]
                                            .weight
                                            .toString() +
                                        " kilo " +
                                        _repControllers[index].text +
                                        " tekrar")
                                    : _exerciseLogs[position].setLogs.length >
                                                index &&
                                            _exerciseLogs[position]
                                                    .setLogs[index]
                                                    .weight ==
                                                0
                                        ? Text("Set " +
                                            (index + 1).toString() +
                                            ", " +
                                            _exerciseLogs[position]
                                                .setLogs[index]
                                                .reps
                                                .toString() +
                                            " tekrar")
                                        : Text(
                                            "Set " +
                                                (index + 1).toString() +
                                                ", " +
                                                widget.workout.exerciseTargetsList[position].minRep
                                                    .toString() +
                                                "-" +
                                                widget.workout.exerciseTargetsList[position].maxRep
                                                    .toString() +
                                                " tekrar",
                                            style: _exerciseLogs[position].setLogs.length == index
                                                ? TextStyle(color: Colors.blue)
                                                : TextStyle(color: Colors.black)))
                            : ListTile(
                                title: _exerciseLogs[position].setLogs.length > index && _exerciseLogs[position].setLogs[index].weight != 0
                                    ? Text("Set " + (index + 1).toString() + ", " + _exerciseLogs[position].setLogs[index].weight.toString() + " kilo " + _repControllers[index].text + " saniye")
                                    : _exerciseLogs[position].setLogs.length > index && _exerciseLogs[position].setLogs[index].weight == 0
                                        ? Text("Set " + (index + 1).toString() + ", " + _exerciseLogs[position].setLogs[index].duration.toString() + " saniye")
                                        : Text("Set " + (index + 1).toString() + ", " + widget.workout.exerciseTargetsList[position].duration.toString() + " saniye", style: _exerciseLogs[position].setLogs.length == index ? TextStyle(color: Colors.blue) : TextStyle(color: Colors.black))),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExerciseVideoPage(int position) {
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=USxvy07gjPA&ab_channel=A%C4%9EIRSA%C4%9ELAM");
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }

  Widget buildLastWorkoutPage(int position) {
    return ChangeNotifierProvider<WorkoutHelperOldLogsViewModel>(
      create: (context) => WorkoutHelperOldLogsViewModel(
          widget.workout.exerciseTargetsList[position].exercise),
      child: Consumer<WorkoutHelperOldLogsViewModel>(
          builder: (context, oldLogsVM, child) {
        return oldLogsVM.state == DataReady.Ready
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child: oldLogsVM.dates.length > 0
                        ? Card(
                            child: ListTile(
                              title: Text(
                                  calculateDaysAgo(oldLogsVM.dates.last),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                              subtitle: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: oldLogsVM
                                    .exerciseLogsList.last.setLogs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      title: oldLogsVM.exerciseLogsList.last
                                                  .setLogs[index].duration ==
                                              null
                                          ? oldLogsVM.exerciseLogsList.last.setLogs[index].weight !=
                                                  0
                                              ? Text("Set " +
                                                  (index + 1).toString() +
                                                  ", " +
                                                  oldLogsVM
                                                      .exerciseLogsList
                                                      .last
                                                      .setLogs[index]
                                                      .weight
                                                      .toString() +
                                                  " kg " +
                                                  oldLogsVM.exerciseLogsList
                                                      .last.setLogs[index].reps
                                                      .toString() +
                                                  " tekrar")
                                              : Text("Set " +
                                                  (index + 1).toString() +
                                                  ", " +
                                                  oldLogsVM.exerciseLogsList
                                                      .last.setLogs[index].reps
                                                      .toString() +
                                                  " tekrar")
                                          : oldLogsVM.exerciseLogsList.last.setLogs[index].weight !=
                                                  0
                                              ? Text("Set " +
                                                  (index + 1).toString() +
                                                  ", " +
                                                  oldLogsVM.exerciseLogsList.last.setLogs[index].weight.toString() +
                                                  " kg " +
                                                  oldLogsVM.exerciseLogsList.last.setLogs[index].duration.toString() +
                                                  " saniye")
                                              : Text("Set " + (index + 1).toString() + ", " + oldLogsVM.exerciseLogsList.last.setLogs[index].duration.toString() + " saniye"));
                                },
                              ),
                            ),
                          )
                        : Card(
                            child: ListTile(
                            title: Text("Egzersiz Geçmişi",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400)),
                            subtitle:
                                Text("Egzersiz geçmişiniz bulunmamaktadır."),
                          ))),
              )
            : LoadingScreen();
      }),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
