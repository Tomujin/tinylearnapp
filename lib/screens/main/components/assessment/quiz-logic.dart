import 'question.dart';

class QuizLogic {
  // Post post = new Post(
  //     title: 'Linear Equition Assessment',
  //     postType: 'Assessment',
  //     description: 'Find the x',
  //     contents: [
  //       new Content(
  //           mediaType: 'Image',
  //           sourcePath:
  //               'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Linear_Function_Graph.svg/1200px-Linear_Function_Graph.svg.png',
  //           answerType: 'MultipleChoice',
  //           answers: [
  //             new ContentAnswer(mediaType: 'Text', answer: '1', point: 0),
  //             new ContentAnswer(mediaType: 'Text', answer: '5', point: 1),
  //             new ContentAnswer(mediaType: 'Text', answer: '15', point: 0),
  //             new ContentAnswer(mediaType: 'Text', answer: '25', point: 0)
  //           ])
  //     ]);

  Post post = new Post(
      title: 'Linear Equition Assessment',
      postType: 'Assessment',
      description: 'Find the x',
      contents: [
        new Content(
            mediaType: 'Latex',
            contentText: 'y = 2x + 1',
            sourcePath:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Linear_Function_Graph.svg/1200px-Linear_Function_Graph.svg.png',
            //'https://counselingmp3.s3-ap-northeast-1.amazonaws.com/138384948_398985458034903_4052419941179097566_n.mp4',
            answerType: 'MultipleChoice',
            answers: [
              new ContentAnswer(mediaType: 'Text', answer: '1', point: 0),
              new ContentAnswer(mediaType: 'Text', answer: '5', point: 1),
              new ContentAnswer(mediaType: 'Text', answer: '15', point: 0),
              new ContentAnswer(mediaType: 'Text', answer: '25', point: 0)
            ])
      ]);

  Post getPost() {
    return this.post;
  }
}
