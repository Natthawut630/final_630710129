import 'package:election_2566_poll/services/api.dart';
import 'package:flutter/material.dart';

import '../../models/poll.dart';
import '../../models/response_body.dart';
import '../my_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Poll>? _polls;
  List<ResponseBody>? _respon;
  var _isLoading = false;

  bool _isError = false;
  String _errMessage = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    setState(() {
      _isLoading = true;
    });
    try{
      var result = await ApiClient().getAllPoll();
      setState(() {
        _polls = result;
      });
    }catch(e){
      setState(() {
        _errMessage = e.toString();
        _isError = true;
      });
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
    // todo: Load list of polls here
  }



  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Image.network('https://cpsu-test-api.herokuapp.com/images/election.jpg'),
          Expanded(
            child: Stack(
              children: [
                if (_polls != null) _buildList(),
                if (_isLoading) _buildProgress(),


              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: _polls!.length,
      itemBuilder: (BuildContext context, int index) {
        String textCPoll = _polls![index].choices.toString();
        List<String> CPolls = textCPoll.split(',');
        List<String> textQ = [
          '1. บุคคลใดที่คุณสนับสนุนให้เป็นนายกรัฐมนตรีในการเลือกตั้งครั้งนี้',
          '2. ในการเลือกตั้ง ส.ส เเบบเเบ่งเขต คุณจะเลือกผู้สมัครจากพรรคการเมืองใด',
          '3. ในการเลือกตั้ง ส.ส เเบบบัญชีรายชื่อ คุณจะเลือกผู้สมัครจากพรรคการเมืองใด',
        ];

        // todo: Create your poll item by replacing this Container()
        return Container(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(textQ[index]),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[0])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[1])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[2])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[3])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[4])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[5])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[6])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[7])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[8])),
                    OutlinedButton(onPressed: (){_loadData();},child: Text(CPolls[9])),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed: (){

                      }, child: const Text('ดูผลโหวต')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  Widget _buildProgress() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.white),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('รอสักครู่', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
