import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/model/feedback_model.dart';
import 'package:pbp_2_restaurant/repository/feedback_repository.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedbackController = TextEditingController();
  TextEditingController _editController = TextEditingController();

  int _selectedIndex = -1;
  bool _isEditing = false;
  List<Map<String, dynamic>> feedback = [];

  void initState() {
    super.initState();
    refresh(); // Panggil refresh saat halaman dimuat
  }

  Future<void> refresh() async {
    final data = await FeedbackRepository.fetchFeedback();
    setState(() {
      feedback =
          List<Map<String, dynamic>>.from(data.map((item) => toFeedback(item)));
      print(feedback);
    });
  }

  Map<String, dynamic> toFeedback(dynamic item) {
    return {
      "id": item.id,
      "id_user": item.idUser,
      "comment": item.comment,
      "status": item.status,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback App'),
        backgroundColor: Color(0xFFD9114D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [SizedBox(height: 16),
            TextField(
              key: const Key('TextFieldFeedback'),
              controller: _feedbackController,
              enabled: !_isEditing,
              decoration: InputDecoration(
                hintText: 'Masukkan Feedback Anda',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              key: const Key('ButtonAdd'),
              onPressed: () {
                _submitFeedback();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFFD9114D), // Warna teks
              ),
              child: Text('Kirim Feedback'),
            ),
            SizedBox(height: 16),
            Text(
              'Feedback yang Telah Terkirim:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: feedback.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: _buildFeedbackText(index),
                      subtitle: Text('Status: ' + feedback[index]['status'],
                          style: TextStyle(color: Colors.green)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isEditing) ...[
                            IconButton(
                              key: const Key('ButtonEdit'),
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editFeedback(index);
                              },
                            ),
                            IconButton(
                              key: const Key('ButtonDelete'),
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteFeedback(index);
                              },
                            ),
                          ] else ...[
                            IconButton(
                              key: const Key('ButtonSave'),
                              icon: Icon(Icons.save),
                              onPressed: () {
                                _saveEditedFeedback();
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackText(int index) {
    if (_selectedIndex == index) {
      return TextField(
        controller: _editController,
      );
    } else {
      return Text(feedback[index]['comment']);
    }
  }

  void _submitFeedback() async {
    String feedbackText = _feedbackController.text.trim();
    if (feedbackText.isNotEmpty) {
      try {
        FeedbackModel input = FeedbackModel(
          idUser: widget.id,
          comment: feedbackText,
        );

        await FeedbackRepository.feedbackCreate(data: input);

        // Refresh data feedback setelah feedback dibuat
        await refresh();
        _feedbackController.clear();
      } catch (e) {
        // Handle error
        print('widget.id type: ${widget.id.runtimeType}');
        print('Error submitting feedback: $e');
      }
    }
  }

  void _editFeedback(int index) {
    setState(() {
      _selectedIndex = index;
      _editController.text = feedback[index]['comment'];
      _isEditing = true;
    });
  }

  void _deleteFeedback(int index) async {
    try {
      await FeedbackRepository.feedbackDelete(id: feedback[index]['id']);
      await refresh();
      _selectedIndex = -1;
      _isEditing = false;
    } catch (e) {
      // Handle error
      print('Error deleting feedback: $e');
    }
  }

  void _saveEditedFeedback() async {
    if (_selectedIndex != -1) {
      try {
        FeedbackModel input = FeedbackModel(
          id: feedback[_selectedIndex]['id'],
          comment: _editController.text,
          idUser: widget.id,
        );
        await FeedbackRepository.feedbackEdit(data: input);
        // Refresh data feedback setelah feedback diupdate
        await refresh();
        _selectedIndex = -1;
        _isEditing = false;
        _editController.clear();
      } catch (e) {
        // Handle error
        print('Error saving edited feedback: $e');
      }
    }
  }
}
