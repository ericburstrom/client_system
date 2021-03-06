part of '../program.dart';

class InputItems {
  Widget WidgetImage(double width, double height, String image) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child:
            Container(width: width, height: height, child: Image.asset(image)),
      ),
    );
  }

  Widget WidgetTextFormField(
      String lableText, String hintText, TextEditingController controller) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: lableText,
            hintText: hintText),
        validator: (value) {
          if (value!.isEmpty) {
            return lableText + ' is required';
          }
        },
      ),
    );
  }

  Widget WidgetTextLink(Function onPressed, String text) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.blue, fontSize: 15),
      ),
    );
  }

  Widget WidgetButton(BuildContext context, Function onPressed, String text) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          onPressed(context);
        },
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              backgroundColor: Colors.blueAccent,
              fontSize: 25),
        ),
      ),
    );
  }

  Widget WidgetSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget WidgetStringRadioButton(Function state, List<String> values,
      List<String> radioValue, List<String> translations) {
    Widget radioButton(String name) {
      return Radio(
          value: name,
          groupValue: radioValue[0],
          onChanged: (s) {
            radioValue[0] = s as String;
            state();
          });
    }

    var radioWidgets = <Widget>[];
    for (var i = 0; i < values.length; i++) {
      radioWidgets.add(radioButton(values[i]));
      radioWidgets.add(Text(translations[i]));
    }
    return Row(children: radioWidgets);
  }

  Color GetColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Widget WidgetCheckbox(
      Function state, Function onChanged, String text, List<bool> toggles) {
    List<Widget> checkWidgets = [];

    checkWidgets.add(Container(
        height: 20,
        child: Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(GetColor),
            value: toggles[0],
            onChanged: (bool? value) {
              toggles[0] = value!;
              onChanged();
              state();
            })));
    checkWidgets.add(Text(text));
    return Row(children: checkWidgets);
  }

  Widget WidgetSlider(BuildContext context, Function state, Function onChanged,
      String text, List<double> slider, int offset) {
    var sliderWidgets = <Widget>[];

    sliderWidgets.add(SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.blue,
          inactiveTrackColor: Colors.blue,
          trackShape: const RectangularSliderTrackShape(),
          trackHeight: 2.0,
          thumbColor: Colors.blueAccent,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
          overlayColor: Colors.red.withAlpha(32),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 10.0),
        ),
        child: Container(
            //width: 150,
            height: 15,
            child: Slider(
              value: slider[offset],
              onChanged: (value) {
                slider[offset] = value;
                onChanged();
                state();
              },
            ))));
    sliderWidgets.add(Text(text));
    return Row(children: sliderWidgets);
  }

  Widget WidgetDropDownList(
      Function state, String text, List<String> items, List<String> choice) {
    var dropWidgets = <Widget>[];

    dropWidgets.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: DropdownButton<String>(
          value: choice[0],
          icon: const Icon(Icons.arrow_downward),
          iconSize: 12,
          elevation: 8,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            choice[0] = newValue!;
            state();
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )));
    dropWidgets.add(Text(text));
    return Row(children: dropWidgets);
  }

  Widget WidgetWrapCCOverlay(BuildContext context, Function state) {
    if (application.GameDices.UnityColorChangeOverlay[0]) {
      return Positioned(
          left: 0,
          top: 380,
          child: Container(
              color: Colors.white,
              width: 250,
              height: 150,
              child: ListView(
                  children:
                      gameSelect.WidgetColorChangeOverlay(context, state))));
    } else {
      return Container();
    }
  }

  Widget WidgetParagraph(String text) {
    var paragraphWidgets = <Widget>[];
    paragraphWidgets.add(Text(text,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontStyle: FontStyle.italic)));
    paragraphWidgets.add(const Divider(
      height: 20,
      thickness: 2,
      indent: 0,
      endIndent: 50,
    ));
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: paragraphWidgets);
  }
}
