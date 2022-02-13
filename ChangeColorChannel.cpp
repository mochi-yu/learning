//--- �摜�̓ǂݍ��݁A�\���A�ۑ� ---//
#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;
string win_src = "src";
string win_dst = "dst";

int main(int arge, char** argv) {
	string file_src = "lena_std.bmp";	// ���͉摜�̃t�@�C����
	string file_dst = "dst.png";	// �o�͉摜�̃t�@�C����

	Mat img_src = imread(file_src, 1);		// ���͉摜(�J���[)�̓ǂݍ���
	// Mat img_src = imread(file_src, 0);	// ���͉摜(�O���[�X�P�[��)�̓ǂݍ���

	Mat img_dst;
	if (!img_src.data) {
		cout << "error" << endl;
		return -1;
	}

	// �E�B���h�E�̍쐬
	namedWindow(win_src, WINDOW_AUTOSIZE);	// �Q�l���ł́uWINDOW_AUTOSIZE�v���uCV_WINDOW_AUTOSIZE�v�ƂȂ��Ă���̂Œ��ӁB
	namedWindow(win_dst, WINDOW_AUTOSIZE);

	// �����Ɋj�ƂȂ鏈�����L�q����B
	flip(img_src, img_dst, 0);	// �������]

	imshow(win_src, img_src);	// ���͉摜��\��
	imshow(win_dst, img_dst);	// �o�͉摜��\��
	imwrite(file_dst, img_dst);	// �������ʂ̕ۑ�

	waitKey(0);	// �L�[���͑҂�
	return 0;

}