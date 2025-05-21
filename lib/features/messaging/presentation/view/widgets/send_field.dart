import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/attachment_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendField extends StatefulWidget {
  final TextEditingController sendController;
  const SendField({super.key, required this.sendController});

  @override
  State<SendField> createState() => _SendFieldState();
}

class _SendFieldState extends State<SendField> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 150,
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: defaultFormField(
            scrollController: scrollController,
            maxLines: null,
            controller: widget.sendController,
            type: TextInputType.multiline,
            validate: (value) {},
            decoration: InputDecoration(
                suffixIcon: Transform.rotate(
                  alignment: Alignment.bottomLeft,
                  angle: 45,
                  child: IconButton(
                    padding: EdgeInsets.only(left: 15, top: 15, right: 10),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (builder) => AttachmentItems(),
                      );
                    },
                    icon: Icon(Icons.attachment),
                    iconSize: 30,
                    color: Colors.grey,
                  ),
                ),
                fillColor: ColorApp.appBackgroundColor,
                filled: true,
                hintText: 'send your message',
                floatingLabelStyle:
                    const TextStyle(color: ColorApp.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
      ),
    );
  }
}
