import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slark_v2/bloc/SingletonBloc.dart';
import 'package:slark_v2/components/project_summery.dart';
import 'package:slark_v2/models/projectList.dart';

class ProjectsScreen extends StatefulWidget {
  ProjectsScreen(this.spaceid, {Key? key, required this.title})
      : super(key: key);
  final String spaceid;
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
  final String title;
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<String> options = ['All Projects', 'Active Projects', 'Completed'];
  var selectedOption;

  @override
  void initState() {
    if (widget.title == "All Projects") {
      bloc.f_allprojects(context, widget.spaceid);
    }
    if (widget.title == "Active Projects") {
      bloc.f_activeprojects(context, widget.spaceid);
    }
    if (widget.title == "Completed") {
      bloc.f_completedprojects(context, widget.spaceid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f7ef),
        body: StreamBuilder<ProjectList>(
            stream: bloc.ProjectListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10.0),
                              ) +
                              EdgeInsets.only(
                                top: ScreenUtil().setHeight(30.0),
                              ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(20.0),
                                      ) +
                                      EdgeInsets.only(
                                          top: ScreenUtil().setHeight(20.0)),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context, MaterialPageRoute);
                                          },
                                          icon: Icon(Icons.arrow_left)),
                                      Spacer(),
                                      Text(
                                        "${widget.title}",
                                        style: GoogleFonts.poppins(
                                          color: Color(0xff4d3a58),
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(18.0),
                                        ),
                                      ),
                                      Spacer(),
                                      // ignore: deprecated_member_use
                                      PopupMenuButton(
                                        color: Colors.blue[50],
                                        iconSize: 15,
                                        itemBuilder: (context) {
                                          return options.map((option) {
                                            return PopupMenuItem(
                                              value: option,
                                              child: Text(option),
                                            );
                                          }).toList();
                                        },
                                        onSelected: (option) {
                                          setState(() {
                                            selectedOption = option;
                                          });
                                          print(selectedOption);
                                          if (option == 'All Projects') {
                                            setState(() {
                                              selectedOption = option;
                                            });
                                            Navigator.pop(context);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectsScreen(
                                                        widget.spaceid,
                                                        title: selectedOption),
                                              ),
                                            );
                                          } else if (option == 'Completed') {
                                            setState(() {
                                              selectedOption = option;
                                            });
                                            Navigator.pop(context);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectsScreen(
                                                        widget.spaceid,
                                                        title: selectedOption),
                                              ),
                                            );
                                          } else {
                                            setState(() {
                                              selectedOption = option;
                                            });
                                            Navigator.pop(context);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectsScreen(
                                                        widget.spaceid,
                                                        title: selectedOption),
                                              ),
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10.0),
                                ),
                                Expanded(
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      children: List.generate(
                                          snapshot.data!.data!.length, (index) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(10.0),
                                            ),
                                            ProjectSummery(
                                                snapshot.data!.data![index]),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
