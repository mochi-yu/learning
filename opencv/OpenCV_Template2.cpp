//--- �J��������̘A���ǂݍ��� ---//

#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;
string win_src = "src";
string win_dst = "dst";

int main(int arge, char** argv) {
	Mat img_src;
	Mat img_dst;
	VideoCapture capture(0);	// �J�����I�[�v��
	if (!capture.isOpened()) {
		cout << "error" << endl;
		return -1;
	}

	// �E�B���h�E����
	namedWindow(win_src, WINDOW_AUTOSIZE);
	namedWindow(win_dst, WINDOW_AUTOSIZE);

	while (1) {
		capture >> img_src;	// �J�����摜�̓ǂݍ���

		// �����Ɋj�ƂȂ鏈�����L�q����
		flip(img_src, img_dst, 0);	// �������]

		imshow(win_src, img_src);	// ���͉摜��\��
		imshow(win_dst, img_dst);	// �o�͉摜��\��
		if (waitKey(1) == 'q') break;	// q�L�[�ŏI��
	}

	return 0;
}