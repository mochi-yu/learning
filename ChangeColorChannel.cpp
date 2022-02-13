//--- 画像の読み込み、表示、保存 ---//
#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;
string win_src = "src";
string win_dst = "dst";

int main(int arge, char** argv) {
	string file_src = "lena_std.bmp";	// 入力画像のファイル名
	string file_dst = "dst.png";	// 出力画像のファイル名

	Mat img_src = imread(file_src, 1);		// 入力画像(カラー)の読み込み
	// Mat img_src = imread(file_src, 0);	// 入力画像(グレースケール)の読み込み

	Mat img_dst;
	if (!img_src.data) {
		cout << "error" << endl;
		return -1;
	}

	// ウィンドウの作成
	namedWindow(win_src, WINDOW_AUTOSIZE);	// 参考書では「WINDOW_AUTOSIZE」が「CV_WINDOW_AUTOSIZE」となっているので注意。
	namedWindow(win_dst, WINDOW_AUTOSIZE);

	// ここに核となる処理を記述する。
	flip(img_src, img_dst, 0);	// 垂直反転

	imshow(win_src, img_src);	// 入力画像を表示
	imshow(win_dst, img_dst);	// 出力画像を表示
	imwrite(file_dst, img_dst);	// 処理結果の保存

	waitKey(0);	// キー入力待ち
	return 0;

}