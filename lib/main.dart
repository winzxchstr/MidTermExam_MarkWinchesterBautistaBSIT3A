import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Winchester Bautista', 'San Carlos Pangasinan', 'September 2, 2001',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/341085863_246891267736226_7990680996418993910_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=174925&_nc_eui2=AeG_v4BU_g3oaTPkiz9wissAUOBd-gFdmABQ4F36AV2YAI_l6_8VuKeZjXjM6Jc8q1IjTIW-DnXpaNGo0Cu4Hi0B&_nc_ohc=7YBYV5DC5BkAX_sh5jz&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfBYuQdfxuTEJWkeyg1EbnC4NjgktzwXuTlkGG0PKPZHtw&oe=64514FA6'),
    Person('Sandara Teng', 'Urbiztondo, Pangasinan', 'June 24, 2003',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/244053433_106689915116323_8995167384510227872_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEyVkeyxsB2FvXdqL4YxSrVLW500vfa-TctbnTS99r5N043KvjIakbGFYk1Ynn2_2PpA4_Zda7eY1iz5w2r4NZW&_nc_ohc=mU1MrxVLjPEAX95h7xs&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfD3Gh4nHYj9nvW--hih5lwYWwwm2CQc7Pj9pVVs29znzw&oe=6450DDA9'),
    Person('Katie T. Tikho', 'Sin City', 'May 15, 1999',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t1.6435-9/61979257_897180073956828_1513583970174894080_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=174925&_nc_eui2=AeEEA7Heh0uG9sLUclVwE2KfVCZVLJC2zxxUJlUskLbPHHfOjYuuETh_mOwd8tNut4GIZk2KExxSLfXqyGlqc6zh&_nc_ohc=hC5qFz_8UrwAX93yjR7&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfAFuDp7YBCRLL7BagxK6x_LH7YLkJw1oG_QOWMwrNoWFQ&oe=6473F4FC'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIDTERM EXAM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/2677048.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 5, 3, 3),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 13, 9, 9),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Color.fromARGB(255, 0, 0, 0),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
