import 'package:dmarketing/pages/signing/login_screen.dart';
import 'package:dmarketing/pages/signing/root_signup.dart';
import 'package:dmarketing/pages/signing/signup_screen.dart';
import 'package:dmarketing/root_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:provider/provider.dart';


class FirstVisitorPage extends StatefulWidget {
  @override
  _FirstVisitorPageState createState() => _FirstVisitorPageState();
}

class _FirstVisitorPageState extends State<FirstVisitorPage> {
  @override
  void initState() {
    _dropDownMenuItemsCityKind = _getDropDownMenuItemsCityKind();
    _dropDownMenuItemsRegionsKind = _getDropDownMenuItemsRegionsKind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png",
                width: width*0.2,height: height*0.1
                ,fit: BoxFit.cover,
              ),
              Text(
                translate("app_bar.name"),
                style: GoogleFonts.cairo(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color:appColor),
              ),
              SizedBox(height: height*0.07,),
              SizedBox(
                width: width*0.7,
                child: Text(
                  "You are browsing as a visitor register now and get",
                  style: GoogleFonts.cairo(
                      fontSize: width*0.05,
                      fontWeight: FontWeight.bold,
                      color:Colors.black38),textAlign: TextAlign.center,
                ),
              ),
              Text(
                "7 Days for free",
                style: GoogleFonts.cairo(
                    fontSize: width*0.05,
                    fontWeight: FontWeight.bold,
                    color:colorStar),textAlign: TextAlign.center,
              ),
              SizedBox(height: height*0.02,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                  MainSignUpPage()));
                },
                child: Text(
                  translate("signup.signup"),
                  style: GoogleFonts.cairo(
                    color: colorWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: width*0.05,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: appColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(width * 0.8,height * 0.070),
                ),
              ),
              SizedBox(height: height*0.02,),
              Text(
                "Or",
                style: GoogleFonts.cairo(
                    fontSize: width*0.05,
                    fontWeight: FontWeight.bold,
                    color:Colors.black38),textAlign: TextAlign.center,
              ),
              Text(
                translate("signup.already_have_account"),
                style: GoogleFonts.cairo(
                    fontSize: width*0.05,
                    fontWeight: FontWeight.bold,
                    color:Colors.black38),textAlign: TextAlign.center,
              ),
              SizedBox(height: height*0.02,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                      LoginScreen()));
                },
                child: Text(
                  translate("login.app_bar"),
                  style: GoogleFonts.cairo(
                    color: appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: width*0.05,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: colorWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),side: BorderSide(
                    width: 1,color: appColor
                  )),
                  minimumSize: Size(width * 0.8,height * 0.070),
                ),
              ),
              SizedBox(height: height*0.02,),
              Visibility(
                visible: Constant.userName=="market"?false:true,
                child: GestureDetector(
                  child: Text(translate("button.skip"),style: GoogleFonts.cairo(fontWeight: FontWeight.bold,
                      color: appColor,fontSize: width*0.06,decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.double),),
                  onTap: (){
                    chooseCityRegion(context: context, height: height,width:width);
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


  chooseCityRegion({double height,double width,BuildContext context}){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: height*0.4-20,
                  color: Colors.transparent,
                  child: new Container(
                      padding: EdgeInsets.symmetric(horizontal: width*0.03,
                          vertical: height*0.02),
                      margin: EdgeInsets.symmetric(
                          vertical: height*0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height*0.02,
                          ),
                          Container(
                            width: width * 0.9,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1,color: Colors.grey),
                                color:colorWhite ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                style: new TextStyle(
                                    color: appColor, fontSize: width * 0.03+4),
                                value: _statusSelCityKind,
                                items: _dropDownMenuItemsCityKind,
                                hint: Text(translate("signup.governorate"),
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.03 + 4),
                                ),
                                onChanged: (selectedItem){
                                  setState(() {
                                    _dropDownMenuItemsRegionsKind.clear();
                                    _statusSelCityKind = selectedItem;
                                    print(_statusSelCityKind);
                                  });
                                  showToast("◌");
                                  // Timer(Duration(seconds: 1),(){
                                  try{
                                    for(int i=0; i<Constant.regions.value.length;i++){
                                      if(Constant.regions.value[i].city_id=="$selectedItem"){
                                        print("selected cityId: ${Constant.regions.value[i].city_id.toString()}");
                                        // _dropDownMenuItemsRegionsKind.clear();
                                        setState(() {
                                          _statusSelRegionsKind=Constant.regions.value[i].id.toString();
                                          _dropDownMenuItemsRegionsKind = _getDropDownMenuItemsRegionsKind(cityID:Constant.regions.value[i].city_id.toString());
                                        });
                                      }
                                    }
                                  }catch(e){print(e);}
                                  // });
                                },
                                icon: new Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height*0.02,
                          ),
                          Container(
                            width: width * 0.9,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1,color: Colors.grey),
                                color:colorWhite ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                style: new TextStyle(
                                    color: appColor, fontSize: width * 0.03+4),
                                value: _statusSelRegionsKind,
                                items: _dropDownMenuItemsRegionsKind,
                                hint: Text(translate("store.city"),
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.03 + 4),
                                ),
                                onChanged: _changeDrownItemRegionsKind,
                                icon: new Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height*0.02,
                          ),

                          Visibility(
                            visible: _statusSelRegionsKind!=null&&_statusSelCityKind!=null?true:false,
                            child: IconButton(
                              icon: Icon(CupertinoIcons.chevron_forward,color: appColor,),
                              onPressed: (){
                                if(_statusSelRegionsKind!=null&&_statusSelCityKind!=null){
                                  Navigator.of(context).push(MaterialPageRoute(builder:
                                      (context)=> RootPages()));
                                }
                              },
                            ),
                          ),

                        ],
                      )),
                );
              });

        }
    );
  }
  //drop down
  List<DropdownMenuItem<String>> _dropDownMenuItemsCityKind;
  String _statusSelCityKind;
  List<DropdownMenuItem<String>> _getDropDownMenuItemsCityKind() {
    List<DropdownMenuItem<String>> itemsCityKind = new List();
    for(int i=0; i<Constant.cities.value.length;i++){
      itemsCityKind.add(new DropdownMenuItem(
        child: new Text(
          "${Constant.cities.value[i].name}",
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
        value: "${Constant.cities.value[i].id}",
      ));
    }
    return itemsCityKind;
  }

  List<DropdownMenuItem<String>> _dropDownMenuItemsRegionsKind;
  String _statusSelRegionsKind;
  List<DropdownMenuItem<String>> _getDropDownMenuItemsRegionsKind({String cityID}) {
    List<DropdownMenuItem<String>> itemsRegionKind = new List();
    for(int i=0; i<Constant.regions.value.length;i++){
      // if(cityID==null){
      //   itemsRegionKind.add(new DropdownMenuItem(
      //     child: new Text(
      //       "${Constant.regions.value[i].name}",
      //       style: GoogleFonts.cairo(
      //         color: appColor,
      //       ),
      //     ),
      //     value: "${Constant.regions.value[i].id}",
      //   ));
      // }else
      if(cityID==Constant.regions.value[i].city_id){
        print("add regionCityId $cityID");
        itemsRegionKind.add(new DropdownMenuItem(
          child: new Text(
            "${Constant.regions.value[i].name}",
            style: GoogleFonts.cairo(
              color: appColor,
            ),
          ),
          value: "${Constant.regions.value[i].id}",
        ));
      }
    }
    return itemsRegionKind;
  }
  void _changeDrownItemRegionsKind(String selectedItem) {
    setState(() {
      _statusSelRegionsKind = selectedItem;
      print(_statusSelRegionsKind);
      Constant.cityID=_statusSelCityKind;
      Constant.region_id=_statusSelRegionsKind;
      Constant.token="discover";
    });
    // Timer(Duration(seconds: 1),(){
    if(_statusSelRegionsKind!=null&&_statusSelCityKind!=null){
      Navigator.of(context).push(MaterialPageRoute(builder:
          (context)=> RootPages()));
    }
    // });
  }
}
