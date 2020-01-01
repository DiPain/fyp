import 'package:fyp/res/dbServer.dart';
import 'package:fyp/res/decor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget{
  String token;
  ImageUpload(this.token);
  _ImageUploadState createState() => _ImageUploadState(this.token);

}
class _ImageUploadState extends State<ImageUpload>{
  String token;
  _ImageUploadState(this.token);
  var _image;

  Future getImage() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
    _image = image;
  });
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
             SizedBox(height: 20,),
                Container(
                  child: FlatButton(
                    child: Text('back'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
            Container(
              width: double.infinity,
              height: 200,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Container(
                  child: 
                    _image == null ?
                    Text('Select an image'):
                    Image.file(_image),
                  ),
                onPressed: (){
                  getImage();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:10, right:10),
              decoration: BoxDecor(color: Colors.blue, radius: 12),
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Container(child: Text('upload'),),
                onPressed: (){
                  if (_image == null){
                    AlertDialog(
                      title: Center(child: Text('no Image selected'),),
                    );
                  }else{
                    DbServer().sendImage(token, _image);
                  }
                },
              ),
            )
          ],),
        ),
      ),
    );
  }
}
