import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD3d4ZJuZbfjOFMbtXBPG6HnYolVcKjb-M",
        projectId: "fir-project1-5bd7d",
        appId: '1:870771416972:android:2b9013672a2ea23ad8c0a9',
        messagingSenderId: '',
        storageBucket: "fir-project1-5bd7d.appspot.com"),
  );
  runApp(MaterialApp(
    home: FireMediaStorage(),
  ));
}

class FireMediaStorage extends StatefulWidget {
  const FireMediaStorage({super.key});

  @override
  State<FireMediaStorage> createState() => _FireMediaStorageState();
}

class _FireMediaStorageState extends State<FireMediaStorage> {
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Media"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () => upload('camera'),
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text("Camera")),
                ElevatedButton.icon(
                    onPressed: () => upload('gallery'),
                    icon: const Icon(Icons.photo),
                    label: const Text("Gallery"))
              ],
            ),
            Expanded(
                child: FutureBuilder(
                  // if firebase connection is success load data or media from firebase
                    future: loadMedia(),

                    /// list of map images will be return here
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              /// each map value from list images stored in map image
                              final Map<String, dynamic> image =
                              snapshot.data![index];
                              return Card(
                                child: ListTile(
                                  leading: Image.network(image['imageurl']),
                                  title: Text(image['uploadedBy']),
                                  subtitle: Text(image['description']),
                                  trailing: IconButton(
                                      onPressed: () => deleteMedia(image['path']),
                                      icon: Icon(Icons.delete)),
                                ),
                              );
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  Future<void> upload(String imageSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;

    try {
      pickedImage = await picker.pickImage(
          source: imageSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);
      final String fileName = path.basename(pickedImage!.path);
      File imagefile = File(pickedImage.path); // import dart.io;
      try {
        await storage.ref(fileName).putFile(
            imagefile,
            SettableMetadata(customMetadata: {
              'uploadedBy': "Its Me Xxxx",
              'description': "Some Description"
            }));
        setState(() {}); // refresh ui
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<Map<String, dynamic>>> loadMedia() async {
    List<Map<String, dynamic>> images = [];
    final ListResult result = await storage.ref().list();
    final List<Reference> allfiles =
        result.items; // all the data from firebase stored as a reference

    await Future.forEach(allfiles, (singlefile) async {
      final String fileUrl = await singlefile
          .getDownloadURL(); // to fetch image path(path as network image path)
      final FullMetadata metadata =
      await singlefile.getMetadata(); // to fetch metadata from firebase

      images.add({
        'imageurl': fileUrl,
        'path': singlefile.fullPath,
        'uploadedBy': metadata.customMetadata?['uploadedBy'] ?? 'No Data',
        'description':
        metadata.customMetadata?['description'] ?? 'No Description'
      });
    });
    return images;
  }

  Future<void> deleteMedia(String imagepath) async {
    await storage.ref(imagepath).delete();
    setState(() {});
  }
}