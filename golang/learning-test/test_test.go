package main_test

import (
	"log"
	"os"
	"testing"
	"time"
)

// 1つの関数で複数のテストを行う（並列ではない）
func TestSubTest(t *testing.T) {
	t.Log("Parent test.")
	t.Run("test1", func(t *testing.T) {
		t.Log("test1")
	})
	t.Run("test2", func(t *testing.T) {
		t.Log("test2")
	})
}

// ヘルパー関数を使用する
func TestHelper(t *testing.T) {
	t.Log("Parent test.")
	helper(t)
}

func helper(t *testing.T) {
	// これを付けると、どのテスト関数から呼び出されたかが分かる
	t.Helper()

	t.Log("Helper func.")
}

// クリーンナップ関数
func TestCleanup(t *testing.T) {
	t.Log("start test.") // 1番目に呼ばれる

	defer t.Log("after cleanup") // 4番目に呼ばれる
	t.Cleanup(func() {
		t.Log("cleanup.") // 5番目（最後）に呼ばれる
	})
	defer t.Log("before cleanup") // 3番目に呼ばれる

	t.Log("end test.") // 2番目に呼ばれる
}

// テストをスキップ
func TestSkip(t *testing.T) {
	t.Log("start test skip")

	// `-short`フラグを付けてテストが実行されるとTrueになる
	if testing.Short() {
		t.Skip("skip")
	}
	t.Log("end test skip")
}

// テストを並列に実行する
func TestParallel(t *testing.T) {
	tests := []struct {
		name string
	}{
		{"test1"}, {"test2"}, {"test3"},
	}

	for _, tt := range tests {
		tt := tt // 並列処理により変数が上書きされるので、シャドウイングをする
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel() // これにより、テストが並列で実行される
			time.Sleep(time.Duration(3) * time.Second)
			t.Log(tt.name)
		})
	}
}

// テスト全体の前処理
func TestMain(m *testing.M) {
	log.Print("before all test.")
	status := m.Run() // 全てのテストを実行
	log.Printf("after all test. status: %d", status)

	os.Exit(status)
}
