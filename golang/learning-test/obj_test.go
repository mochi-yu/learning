package main_test

import (
	"testing"
)

// プリミティブ型のコピーの挙動に関するテスト
func TestPrimitiveCopy(t *testing.T) {
	a1 := "hoge"
	a2 := a1
	a2 = "fuga"
	t.Logf("a1 = %s, a2 = %s", a1, a2)
	if a1 == a2 {
		t.Fail()
	}
}

// スライスのコピーの挙動に関するテスト
func TestSliceCopy(t *testing.T) {
	b1 := make([]int, 2)
	b2 := b1
	b3 := make([]int, 2)
	copy(b3, b1)

	b2[0] = 99  // b1とb2は同じもの
	b3[0] = 999 // b1とb3は違うもの

	t.Logf("b1[0] = %d, b2[0] = %d, b3[0] = %d", b1[0], b2[0], b3[0])
	if b1[0] != b2[0] {
		t.Fail()
	}
	if b1[0] == b3[0] {
		t.Fail()
	}
}

// 配列のコピーの挙動に関するテスト
func TestArrayCopy(t *testing.T) {
	c1 := [2]int{11, 22}
	c2 := c1
	c2[0] = 99 // c1とc2は違うもの
	t.Logf("c1[0] = %d, c2[0] = %d", c1[0], c2[0])
	if c1[0] == c2[0] {
		t.Fail()
	}
}

// map型のコピーの挙動に関するテスト
func TestMapCopy(t *testing.T) {
	d1 := map[int]string{1: "first", 2: "second"}
	d2 := d1
	d3 := map[int]string{}

	for k, v := range d1 {
		d3[k] = v
	}

	d2[1] = "FIRST" // d1とd2は同じインスタンス
	d3[1] = "First" // コピーするには、for文などでコピーする必要がある

	t.Logf("d1[1] = %s, d2[1] = %s, d3[1] = %s", d1[1], d2[1], d3[1])
	if d1[1] != d2[1] {
		t.Fail()
	}
	if d1[1] == d3[1] {
		t.Fail()
	}
}

type MyTypeTestObject struct {
	Str string
	Arr []int
}

func TestStruct(t *testing.T) {
	e1 := MyTypeTestObject{Str: "test", Arr: []int{1, 2}}
	e2 := e1

	t.Logf("e1 addr = %p, e2 addr = %p", &e1, &e2)
	e2.Str = "TEST" // e1とe2は違うインスタンス
	e2.Arr[0] = 99  // だが、内部の配列は同じインスタンス

	t.Logf("e1.Str = %s, e2.Str = %s", e1.Str, e2.Str)
	if e1.Str == e2.Str {
		t.Fail()
	}

	t.Logf("e1.Arr[0] = %d, e2.Arr[0] = %d", e1.Arr[0], e2.Arr[0])
	if e1.Arr[0] != e2.Arr[0] {
		t.Fail()
	}
}
