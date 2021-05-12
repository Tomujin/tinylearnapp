import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:palette_generator/palette_generator.dart';

class StoryDesigner extends StatefulWidget {
  StoryDesigner({Key key, this.filePath}) : super(key: key);

  final String filePath;

  @override
  _StoryDesignerState createState() => _StoryDesignerState();
}

class _StoryDesignerState extends State<StoryDesigner> {
  static GlobalKey previewContainer = new GlobalKey();

  // ActiceItem
  EditableItem _activeItem;

  // item initial position
  Offset _initPos;

  // item current position
  Offset _currentPos;

  // item current scale
  double _currentScale;

  // item current rotation
  double _currentRotation;

  // is item in action
  bool _inAction = false;

  // List of all editableitems
  List<EditableItem> stackData = new List();

  // is textfield shown
  bool isTextInput = false;
  // current textfield text
  String currentText = "";
  // current textfield color
  Color currentColor = Color(0xffffffff);
  // current textfield colorpicker color
  Color pickerColor = Color(0xffffffff);

  // current textfield style
  int currentTextStyle = 0;
  // current textfield fontsize
  double currentFontSize = 26.0;

  // current textfield fontfamily list
  List<String> fontFamilyList = [
    "Lato",
    "Montserrat",
    "Lobster",
    "Spectral SC",
    "Dancing Script",
    "Oswald",
    "Turret Road",
    "Noto Serif",
    "Anton"
  ];
  // current textfield fontfamily
  int currentFontFamily = 0;

  // is activeitem moved to delete position
  bool isDeletePosition = false;
  Color backgroundColor = Colors.grey;
  Image backgroundImage;
  Map<int, Offset> touchPositions = <int, Offset>{};

  void savePointerPosition(int index, Offset position) {
    setState(() {
      touchPositions[index] = position;
    });
  }

  void clearPointerPosition(int index) {
    setState(() {
      touchPositions.remove(index);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      backgroundImage = Image.asset(widget.filePath);
    });

    stackData.add(EditableItem()
      ..type = ItemType.Image
      ..scale = getFitRatio(widget.filePath)
      ..position = getFitOffset(widget.filePath)
      ..value = widget.filePath);
    getDominantColorFromImage();
  }

  Offset getFitOffset(filePath) {
    final imgSize = getImageSize(widget.filePath);
    final dx = (((1.sw / 2) - (imgSize.width / 2)) / 1.sw);
    final dy = ((((1.sh - 45) / 2) - (imgSize.height / 2)) / (1.sh - 45));
    return Offset(dx, dy);
  }

  double getFitRatio(filePath) {
    final Size imageSize = getImageSize(filePath);
    return 1.sw / imageSize.width;
  }

  void getDominantColorFromImage() async {
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(backgroundImage.image);
    setState(() {
      backgroundColor = paletteGenerator.dominantColor.color;
    });
  }

  Size getImageSize(filePath) {
    return ImageSizeGetter.getSize(FileInput(File(filePath)));
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GestureDetector(
              onScaleStart: (details) {
                if (_activeItem == null) return;
                _initPos = details.focalPoint;
                _currentPos = _activeItem.position;
                _currentScale = _activeItem.scale;
                _currentRotation = _activeItem.rotation;
              },
              onScaleUpdate: (details) {
                if (_activeItem == null) return;
                final delta = details.focalPoint - _initPos;
                final left = (delta.dx / screen.width) + _currentPos.dx;
                final top = (delta.dy / screen.height) + _currentPos.dy;

                setState(() {
                  _activeItem.position = Offset(left, top);
                  _activeItem.rotation = details.rotation + _currentRotation;
                  _activeItem.scale = details.scale * _currentScale;
                });
              },
              onTap: () {
                setState(() {
                  isTextInput = !isTextInput;
                  _activeItem = null;
                });

                if (currentText.isNotEmpty) {
                  setState(() {
                    print(Offset(0.5, ((1.sh - 45) / 1.sh) / 2));
                    stackData.add(EditableItem()
                      ..type = ItemType.Text
                      ..value = currentText
                      ..color = currentColor
                      ..position = Offset(0.5, ((1.sh - 45) / 1.sh) / 2)
                      ..textStyle = currentTextStyle
                      ..fontSize = currentFontSize
                      ..fontFamily = currentFontFamily);
                    currentText = "";
                  });
                }
              },
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: KeyboardAvoider(
                      child: Stack(
                        children: [
                          RepaintBoundary(
                            key: previewContainer,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 1.sh - 160,
                                  ),
                                  ...stackData.map(_buildItemWidget).toList(),
                                  Visibility(
                                    visible: isTextInput,
                                    child: Container(
                                      height: screen.height,
                                      width: screen.width,
                                      color: Colors.black.withOpacity(0.4),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              width: screen.width / 1.5,
                                              child: Container(
                                                padding: currentTextStyle != 0
                                                    ? EdgeInsets.only(
                                                        left: 7,
                                                        right: 7,
                                                        top: 5,
                                                        bottom: 5)
                                                    : EdgeInsets.all(0),
                                                decoration: currentTextStyle !=
                                                        0
                                                    ? BoxDecoration(
                                                        color: currentTextStyle ==
                                                                1
                                                            ? Colors.black
                                                                .withOpacity(
                                                                    1.0)
                                                            : Colors.white
                                                                .withOpacity(
                                                                    1.0),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)))
                                                    : BoxDecoration(),
                                                child: TextField(
                                                  autofocus: true,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.getFont(
                                                          fontFamilyList[
                                                              currentFontFamily])
                                                      .copyWith(
                                                          color: currentColor,
                                                          fontSize:
                                                              currentFontSize),
                                                  cursorColor: currentColor,
                                                  maxLines: 3,
                                                  minLines: 1,
                                                  decoration: InputDecoration(
                                                    border:
                                                        new UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                      color: Colors.transparent,
                                                    )),
                                                    focusedBorder:
                                                        new UnderlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                      color: Colors.transparent,
                                                    )),
                                                  ),
                                                  onChanged: (input) {
                                                    setState(() {
                                                      currentText = input;
                                                    });
                                                  },
                                                  onSubmitted: (input) {
                                                    if (input.isNotEmpty) {
                                                      setState(() {
                                                        stackData.add(
                                                            EditableItem()
                                                              ..type =
                                                                  ItemType.Text
                                                              ..value =
                                                                  currentText
                                                              ..color =
                                                                  currentColor
                                                              ..textStyle =
                                                                  currentTextStyle
                                                              ..fontSize =
                                                                  currentFontSize
                                                              ..fontFamily =
                                                                  currentFontFamily);
                                                        currentText = "";
                                                      });
                                                    } else {
                                                      setState(() {
                                                        currentText = "";
                                                      });
                                                    }

                                                    setState(() {
                                                      isTextInput =
                                                          !isTextInput;
                                                      _activeItem = null;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: 40,
                                              child: Container(
                                                width: screen.width,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons
                                                              .color_lens_outlined,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        // raise the [showDialog] widget
                                                        showDialog(
                                                          context: context,
                                                          builder: (ctx) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Pick a color!'),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child:
                                                                    ColorPicker(
                                                                  pickerColor:
                                                                      pickerColor,
                                                                  onColorChanged:
                                                                      (color) {
                                                                    setState(
                                                                        () {
                                                                      pickerColor =
                                                                          color;
                                                                    });
                                                                  },
                                                                  showLabel:
                                                                      true,
                                                                  pickerAreaHeightPercent:
                                                                      0.8,
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: const Text(
                                                                      'Got it'),
                                                                  onPressed:
                                                                      () {
                                                                    setState(() =>
                                                                        currentColor =
                                                                            pickerColor);
                                                                    Navigator.of(
                                                                            ctx)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Container(
                                                          padding: currentTextStyle != 0
                                                              ? EdgeInsets.only(
                                                                  left: 7,
                                                                  right: 7,
                                                                  top: 5,
                                                                  bottom: 5)
                                                              : EdgeInsets.all(
                                                                  0),
                                                          decoration: currentTextStyle != 0
                                                              ? BoxDecoration(
                                                                  color: currentTextStyle == 1
                                                                      ? Colors.black.withOpacity(
                                                                          1.0)
                                                                      : Colors.white.withOpacity(
                                                                          1.0),
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(
                                                                          4)))
                                                              : BoxDecoration(),
                                                          child: Icon(
                                                              Icons.auto_awesome,
                                                              color: currentTextStyle != 2 ? Colors.white : Colors.black)),
                                                      onPressed: () {
                                                        if (currentTextStyle <
                                                            2) {
                                                          setState(() {
                                                            currentTextStyle++;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            currentTextStyle =
                                                                0;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Positioned(
                                              top: ((screen.height) / 2 - 45) -
                                                  (bottom / 2),
                                              left: -120,
                                              child: Transform(
                                                alignment:
                                                    FractionalOffset.center,
                                                // Rotate sliders by 90 degrees
                                                transform:
                                                    new Matrix4.identity()
                                                      ..rotateZ(270 *
                                                          3.1415927 /
                                                          180),
                                                child: SizedBox(
                                                  width: 300,
                                                  child: Slider(
                                                      value: currentFontSize,
                                                      min: 14,
                                                      max: 74,
                                                      activeColor: Colors.white,
                                                      inactiveColor: Colors
                                                          .white
                                                          .withOpacity(0.4),
                                                      onChanged: (input) {
                                                        setState(() {
                                                          currentFontSize =
                                                              input;
                                                        });
                                                      }),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 50,
                                              left: screen.width / 6,
                                              child: Center(
                                                child: Container(
                                                  width: screen.width / 1.5,
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  child: ListView.builder(
                                                      itemCount:
                                                          fontFamilyList.length,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              currentFontFamily =
                                                                  index;
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 40,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                color: index ==
                                                                        currentFontFamily
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            child: Text(
                                                              'Aa',
                                                              style: GoogleFonts
                                                                      .getFont(
                                                                          fontFamilyList[
                                                                              index])
                                                                  .copyWith(
                                                                      color: index ==
                                                                              currentFontFamily
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !isTextInput,
                            child: Visibility(
                              visible: _activeItem != null &&
                                  _activeItem.type != ItemType.Image,
                              child: Positioned(
                                bottom: 50,
                                child: Container(
                                  width: screen.width,
                                  child: Center(
                                      child: Container(
                                    height: !isDeletePosition ? 60.0 : 100,
                                    width: !isDeletePosition ? 60.0 : 100,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                !isDeletePosition ? 30 : 50))),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: !isDeletePosition ? 30 : 50,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !isTextInput,
                            child: Visibility(
                              visible: _activeItem == null,
                              child: Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: screen.width,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 30,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 10.0,
                                                    offset: Offset(0, 0), // c
                                                  ),
                                                ]),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.1),
                                                          spreadRadius: 1,
                                                          blurRadius: 10.0,
                                                          offset:
                                                              Offset(0, 0), // c
                                                        ),
                                                      ]),
                                                  child: Icon(
                                                      Icons.color_lens_outlined,
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  // raise the [showDialog] widget
                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Pick a color!'),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ColorPicker(
                                                            pickerColor:
                                                                pickerColor,
                                                            onColorChanged:
                                                                (color) {
                                                              setState(() {
                                                                pickerColor =
                                                                    color;
                                                              });
                                                            },
                                                            showLabel: true,
                                                            pickerAreaHeightPercent:
                                                                0.8,
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: const Text(
                                                                'Got it'),
                                                            onPressed: () {
                                                              setState(() =>
                                                                  currentColor =
                                                                      pickerColor);
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: Container(
                                                    padding:
                                                        currentTextStyle != 0
                                                            ? EdgeInsets.only(
                                                                left: 7,
                                                                right: 7,
                                                                top: 5,
                                                                bottom: 5)
                                                            : EdgeInsets.all(0),
                                                    decoration: currentTextStyle != 0
                                                        ? BoxDecoration(
                                                            color: currentTextStyle ==
                                                                    1
                                                                ? Colors.black
                                                                    .withOpacity(
                                                                        1.0)
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4)))
                                                        : BoxDecoration(),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 1,
                                                              blurRadius: 10.0,
                                                              offset: Offset(
                                                                  0, 0), // c
                                                            ),
                                                          ]),
                                                      child: Icon(
                                                          Icons.auto_awesome,
                                                          color:
                                                              currentTextStyle !=
                                                                      2
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                    )),
                                                onPressed: () {
                                                  if (currentTextStyle < 2) {
                                                    setState(() {
                                                      currentTextStyle++;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      currentTextStyle = 0;
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    width: screen.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: !isTextInput,
                          child: Visibility(
                            visible: _activeItem == null,
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              onPressed: () async {
                                //done: save image and return captured image to previous screen
                                RenderRepaintBoundary boundary =
                                    previewContainer.currentContext
                                        .findRenderObject();
                                ui.Image image =
                                    await boundary.toImage(pixelRatio: 5.0);
                                // final directory =
                                //     (await getApplicationDocumentsDirectory())
                                //         .path;
                                ByteData byteData = await image.toByteData(
                                    format: ui.ImageByteFormat.png);
                                Uint8List pngBytes =
                                    byteData.buffer.asUint8List();
                                // print(pngBytes);
                                ImageGallerySaver.saveImage(pngBytes,
                                        quality: 60, name: "hello")
                                    .then((result) {
                                  Navigator.of(context).pop();
                                });

                                // File imgFile = new File('$directory/' +
                                //     DateTime.now().toString() +
                                //     '.png');
                                // imgFile.writeAsBytes(pngBytes).then((value) {
                                //   // done: return imgFile
                                //   Navigator.of(context).pop(imgFile);
                                // });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Text(
                                    'Save to gallery',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(EditableItem e) {
    final screen = MediaQuery.of(context).size;
    // double centerHeightPosition = screen.height/2;
    // double centerWidthPosition = screen.width/2;

    var widget;
    switch (e.type) {
      case ItemType.Text:
        if (e.textStyle == 0) {
          widget = Text(
            e.value,
            style: GoogleFonts.getFont(fontFamilyList[e.fontFamily]).copyWith(
              color: e.color,
              fontSize: e.fontSize,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.1, 0.1),
                  blurRadius: 2.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(0.1, 0.1),
                  blurRadius: 1.0,
                  color: Color.fromARGB(0, 0, 0, 255),
                ),
              ],
            ),
          );
        } else if (e.textStyle == 1) {
          widget = Container(
            padding: EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(1.0),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Text(
              e.value,
              style: GoogleFonts.getFont(fontFamilyList[e.fontFamily])
                  .copyWith(color: e.color, fontSize: e.fontSize),
            ),
          );
        } else if (e.textStyle == 2) {
          widget = Container(
            padding: EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(1.0),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Text(
              e.value,
              style: GoogleFonts.getFont(fontFamilyList[e.fontFamily])
                  .copyWith(color: e.color, fontSize: e.fontSize),
            ),
          );
        } else {
          widget = Text(
            e.value,
            style: GoogleFonts.getFont(fontFamilyList[e.fontFamily])
                .copyWith(color: e.color, fontSize: e.fontSize),
          );
        }
        break;
      case ItemType.Image:
        widget = Container(
          child: Image.file(new File(e.value)),
        );
    }

    // e.position = Offset(centerHeightPosition, centerWidthPosition);

    return Positioned(
      top: e.position.dy * screen.height,
      left: e.position.dx * screen.width,
      child: Transform.scale(
        scale: e.scale,
        child: Transform.rotate(
          angle: e.rotation,
          child: Listener(
            onPointerDown: (details) {
              savePointerPosition(details.pointer, details.position);
              if (e.type != ItemType.Image ||
                  (e.type == ItemType.Image && touchPositions.length == 2)) {
                if (_inAction) return;
                _inAction = true;
                _activeItem = e;
                _initPos = details.position;
                _currentPos = e.position;
                _currentScale = e.scale;
                _currentRotation = e.rotation;
              }
            },
            onPointerUp: (details) {
              clearPointerPosition(details.pointer);
              _inAction = false;
              if (e.type != ItemType.Image) {
                // print("e.position.dy: " + e.position.dy.toString());
                // print("e.position.dx: " + e.position.dx.toString());
                if (e.position.dy >= (((1.sh - 190) / 1.sh) * 0.8) &&
                    e.position.dy < (((1.sh - 90) / 1.sh) * 0.8) &&
                    e.position.dx >= (((1.sw / 2) - 60) / 1.sw) &&
                    e.position.dx <= (((1.sw / 2) + 60) / 1.sw)) {
                  print('Delete the Item');

                  setState(() {
                    stackData.removeAt(stackData.indexOf(e));
                    _activeItem = null;
                  });
                }
              }

              setState(() {
                _activeItem = null;
              });
            },
            onPointerCancel: (details) {
              clearPointerPosition(details.pointer);
              setState(() {
                _activeItem = null;
              });
            },
            onPointerMove: (details) {
              savePointerPosition(details.pointer, details.position);
              // print("e.position.dy: " + e.position.dy.toString());
              // print("e.position.dx: " + e.position.dx.toString());
              if (e.type != ItemType.Image) {
                if (e.position.dy >= (((1.sh - 190) / 1.sh) * 0.8) &&
                    e.position.dy < (((1.sh - 90) / 1.sh) * 0.8) &&
                    e.position.dx >= (((1.sw / 2) - 60) / 1.sw) &&
                    e.position.dx <= (((1.sw / 2) + 60) / 1.sw)) {
                  print('Delete the Item');
                  setState(() {
                    isDeletePosition = true;
                  });
                } else {
                  setState(() {
                    isDeletePosition = false;
                  });
                }
              }
            },
            child: widget,
          ),
        ),
      ),
    );
  }
}

enum ItemType { Image, Text }

class EditableItem {
  Offset position = Offset(0.4, 0.4);
  double scale = 1.0;
  double rotation = 0.0;
  ItemType type;
  String value;
  Color color;
  int textStyle;
  double fontSize;
  int fontFamily;
}
