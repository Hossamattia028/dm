import 'dart:io';

import 'package:dmarketing/repository/store/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dmarketing/elements/PermissionDeniedWidget.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:dmarketing/models/Constant.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  ScrollController scrollController ;
  @override
  void initState() {
    scrollController = new ScrollController();
    _dropDownMenuItemsSubSection = _getDropDownMenuItemsSubSection();
    _dropDownMenuItemsDeptKind = _getDropDownMenuItemsDeptKind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var categoryProvider = Provider.of<CategoriesProvider>(context);
    categoryProvider.getCategories();
    categoryProvider.getSubCategories("1");
    return Scaffold(
        backgroundColor: colorWhite,
        body: Constant.id!=null?
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: height*0.01,),
              Container(
                  height: height*0.7-30,
                  child: Scrollbar(
                    thickness: width*0.02,
                    isAlwaysShown: true,
                    radius: Radius.circular(10),
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height: height*0.1+43,
                            width:width,
                            padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.grey,),
                                    SizedBox(width: width*0.02,),
                                    Text(translate("store.title"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                        color: Colors.black54),),
                                  ],
                                ),
                                SizedBox(height: height*0.02,),
                                Container(
                                    width: width * 0.9,
                                    height: height*0.1-30,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[50], borderRadius: BorderRadius.circular(30)),
                                    child: TextFormField(
                                      controller: titleTextController,
                                      textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusColor: Colors.grey,
                                        focusedBorder: InputBorder.none,

                                      ),
                                    )),

                              ],
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          Container(
                            height: height*0.2-10,
                            width:width,
                            padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.grey,),
                                    SizedBox(width: width*0.02,),
                                    Text(translate("store.add_image"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                        color: Colors.black54),),
                                  ],
                                ),
                                SizedBox(height: height*0.01,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child:
                                        GestureDetector(
                                          onTap: ()async{
                                            await selectImage().then((value) {
                                              setState(() {
                                                imageFileUploadOne = value;
                                              });
                                            });
                                          },
                                          child:imageFileUploadOne==null? Image.asset("assets/images/photo.png",width: width*0.2,
                                            height: height*0.09,fit: BoxFit.fill,):
                                          Image.file(imageFileUploadOne,width: width*0.2,
                                            height: height*0.09,fit: BoxFit.fill,),
                                        )
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child:
                                        GestureDetector(
                                          onTap: ()async{
                                            await selectImage().then((value) {
                                              setState(() {
                                                imageFileUploadTwo = value;
                                              });
                                            });
                                          },
                                          child:imageFileUploadTwo==null? Image.asset("assets/images/photo.png",width: width*0.2,
                                            height: height*0.09,fit: BoxFit.fill,):
                                          Image.file(imageFileUploadTwo,width: width*0.2,
                                            height: height*0.09,fit: BoxFit.fill,),
                                        )
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          Container(
                            height: height*0.3-40,
                            width:width,
                            padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.grey,),
                                    SizedBox(width: width*0.02,),
                                    Text(translate("store.choose_category"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                        color: Colors.black54),),
                                  ],
                                ),
                                SizedBox(height: height*0.02,),
                                Container(
                                  width: width * 0.9,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(width: 1,color: Colors.grey),
                                      color:colorWhite ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      style: new TextStyle(
                                          color: appColor, fontSize: width * 0.03+4),
                                      value: _statusSelDeptKind,
                                      items: _dropDownMenuItemsDeptKind,
                                      hint: Text(translate("store.dept"),
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.03 + 4),
                                      ),
                                      onChanged: _changeDrownItemDeptKind,
                                      icon: new Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.02,),
                                Container(
                                  width: width * 0.9,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(width: 1,color: Colors.grey),
                                      color:colorWhite ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      style: new TextStyle(
                                          color: appColor, fontSize: width * 0.03+4),
                                      value: _statusSelSubSection,
                                      items: _dropDownMenuItemsSubSection,
                                      hint: Text(translate("store.sub_section"),
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.03 + 4),
                                      ),
                                      onChanged: _changeDrownItemSubSection,
                                      icon: new Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          Container(
                            height: height*0.1+43,
                            width:width,
                            padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.grey,),
                                    SizedBox(width: width*0.02,),
                                    Text(translate("store.price"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                        color: Colors.black54),),
                                  ],
                                ),
                                SizedBox(height: height*0.02,),
                                Container(
                                    width: width * 0.9,
                                    height: height*0.1-30,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[50], borderRadius: BorderRadius.circular(30)),
                                    child: TextFormField(
                                      controller: priceTextController,
                                      keyboardType: TextInputType.number,
                                      textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusColor: Colors.grey,
                                        focusedBorder: InputBorder.none,

                                      ),
                                    )),

                              ],
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          Container(
                            height: height*0.1+43,
                            width:width,
                            padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.grey,),
                                    SizedBox(width: width*0.02,),
                                    Text(translate("store.size"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                        color: Colors.black54),),
                                  ],
                                ),
                                SizedBox(height: height*0.02,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: width * 0.3,
                                        height: height*0.1-30,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[50], borderRadius: BorderRadius.circular(30)),
                                        child: TextFormField(
                                          controller: sizeOneTextController,
                                          textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),
                                            focusColor: Colors.grey,
                                            focusedBorder: InputBorder.none,

                                          ),
                                        )),
                                    Container(
                                        width: width * 0.3,
                                        height: height*0.1-30,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[50], borderRadius: BorderRadius.circular(30)),
                                        child: TextFormField(
                                          controller: sizeTwoTextController,
                                          textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),
                                            focusColor: Colors.grey,
                                            focusedBorder: InputBorder.none,

                                          ),
                                        )),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          Container(
                            height: height*0.1+50,
                            width:width,
                            padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.grey,),
                                    SizedBox(width: width*0.02,),
                                    Text(translate("store.discount"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                        color: Colors.black54),),
                                  ],
                                ),
                                SizedBox(height: height*0.01,),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      width: width-60,
                                      height: height*0.08,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50], borderRadius: BorderRadius.circular(30)),
                                      child: TextFormField(
                                        controller: discountTextController,
                                        textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          focusColor: Colors.grey,
                                          focusedBorder: InputBorder.none,
                                          hintText: "10%"
                                        ),
                                      )),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          Container(
                            height: height*0.2-10,
                            width:width,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.grey,),
                                    SizedBox(width: width*0.02,),
                                    Text(translate("store.description"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                                        color: Colors.black54),),
                                  ],
                                ),
                                SizedBox(height: height*0.01,),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      width: width-60,
                                      height: height*0.1,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50], borderRadius: BorderRadius.circular(30)),
                                      child: TextFormField(
                                        controller: descriptionTextController,
                                        textAlign: Constant.lang == "ar" ? TextAlign.right : TextAlign.left,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          focusColor: Colors.grey,
                                          focusedBorder: InputBorder.none,

                                        ),
                                        minLines: 5,
                                        maxLines: 7,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: height*0.01,),
                          // Container(
                          //   height: height*0.2-25,
                          //   width:width,
                          //   padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     color: colorWhite,
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Icon(Icons.circle,color: Colors.grey,),
                          //           SizedBox(width: width*0.02,),
                          //           Text(translate("store.city"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                          //               color: Colors.black54),),
                          //         ],
                          //       ),
                          //       SizedBox(height: height*0.02,),
                          //       Container(
                          //         width: width * 0.9,
                          //         alignment: Alignment.center,
                          //         padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(15),
                          //             border: Border.all(width: 1,color: Colors.grey),
                          //             color:colorWhite ),
                          //         child: DropdownButtonHideUnderline(
                          //           child: DropdownButton(
                          //             isExpanded: true,
                          //             style: new TextStyle(
                          //                 color: appColor, fontSize: width * 0.03+4),
                          //             value: _statusSelCityKind,
                          //             items: _dropDownMenuItemsCityKind,
                          //             hint: Text(translate("store.city"),
                          //               style: GoogleFonts.cairo(
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: width * 0.03 + 4),
                          //             ),
                          //             onChanged: _changeDrownItemCityKind,
                          //             icon: new Icon(Icons.keyboard_arrow_down),
                          //           ),
                          //         ),
                          //       ),
                          //
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: height*0.03,),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: ()async{
                                if (imageFileUploadOne!=null||imageFileUploadTwo!=null||
                                    descriptionTextController.text.toString().trim().isNotEmpty||
                                    priceTextController.text.toString().trim().isNotEmpty||
                                    discountTextController.text.toString().trim().isNotEmpty||
                                    titleTextController.text.toString().trim().isNotEmpty) {
                                  await categoryProvider.addProduct(
                                    context: context,
                                    price: priceTextController.text.toString().trim(),
                                    text: descriptionTextController.text.toString().trim(),
                                    title: titleTextController.text.toString().trim(),
                                    discount: discountTextController.text.toString().trim(),
                                    size_one: sizeOneTextController.text.toString().trim(),
                                    size_two: sizeTwoTextController.text.toString().trim(),
                                    image_one: imageFileUploadOne,
                                    image_two: imageFileUploadTwo,
                                    catID: _statusSelDeptKind.toString(),
                                    subCatID: _statusSelSubSection.toString(),
                                    cityID: Constant.cityID.toString(),
                                  );
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: width*0.3,
                                height: height * 0.07,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Text(translate("store.done"),
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold, color: colorWhite),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height*0.05,),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        )
            :PermissionDeniedWidget()
    );
  }
  bool old=false;
  final TextEditingController titleTextController = new TextEditingController();
  final TextEditingController discountTextController = new TextEditingController();
  final TextEditingController sizeOneTextController = new TextEditingController();
  final TextEditingController sizeTwoTextController = new TextEditingController();
  final TextEditingController descriptionTextController = new TextEditingController();
  final TextEditingController priceTextController = new TextEditingController();
  File imageFileUploadOne,imageFileUploadTwo;
  static Future<File> selectImage() async {
    File image;
    final _imagePicker = ImagePicker();
    final pickedImage =
    await _imagePicker.getImage(source: ImageSource.gallery);
    if (_imagePicker != null &&
        pickedImage != null &&
        pickedImage.path != null) {
      image = File(pickedImage.path);
      print("imagePath\n"+image.path);
    } else {
      print("No Image Selected");
    }
    return image;
  }

  //drop down
  List<DropdownMenuItem<String>> _dropDownMenuItemsSubSection;
  String _statusSelSubSection;
  List<DropdownMenuItem<String>> _getDropDownMenuItemsSubSection({String mainCatID}) {
    List<DropdownMenuItem<String>> itemsCityKind = new List();
    for(int i=0; i<Constant.subCategories.value.length;i++){
      print("onForLoop: $mainCatID");
      if(mainCatID==Constant.subCategories.value[i].main_category_id){
        itemsCityKind.add(new DropdownMenuItem(
          child: new Text(
            "${Constant.subCategories.value[i].name}",
            style: GoogleFonts.cairo(
              color: appColor,
            ),
          ),
          value: "${Constant.subCategories.value[i].id}",
        ));
      }
    }
    return itemsCityKind;
  }
  void _changeDrownItemSubSection(String selectedItem) {
    setState(() {
      _statusSelSubSection = selectedItem;
      print(_statusSelSubSection);
    });
  }


  List<DropdownMenuItem<String>> _dropDownMenuItemsDeptKind;
  String _statusSelDeptKind;
  List<DropdownMenuItem<String>> _getDropDownMenuItemsDeptKind() {
    List<DropdownMenuItem<String>> itemsMarketKind = new List();
    for(int i=0; i<Constant.categories.value.length;i++){
      itemsMarketKind.add(new DropdownMenuItem(
        child: new Text(
          "${Constant.categories.value[i].name}",
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
        value: "${Constant.categories.value[i].id}",
      ));
    }
    return itemsMarketKind;
  }
  void _changeDrownItemDeptKind(String selectedItem) {
    setState(() {
      _dropDownMenuItemsSubSection.clear();
      _statusSelDeptKind = selectedItem;
      print("mainCatID: "+_statusSelDeptKind);
    });
    print("main catID on sub catID: "+Constant.subCategories.value.first.main_category_id);
    try{
      for(int i=0; i<Constant.subCategories.value.length;i++){
        if(Constant.subCategories.value[i].main_category_id=="$_statusSelDeptKind"){
          print("selected Main_category_id: ${Constant.subCategories.value[i].main_category_id.toString()}");
          setState(() {
            _statusSelSubSection=Constant.subCategories.value[i].id.toString();
            _dropDownMenuItemsSubSection = _getDropDownMenuItemsSubSection(mainCatID:Constant.subCategories.value[i].main_category_id.toString());
          });
        }
      }
    }catch(e){print(e);}
  }

}
