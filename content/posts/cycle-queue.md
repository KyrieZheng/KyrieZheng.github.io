---
title: "循环队列"
date: 2021-07-23T15:22:15+08:00
---

## 数据结构-队列
### 队列
队列的概念 就是先进先出 队列的两个基本操作 入队（push）出对（pop）

### 顺序队列 / 链式队列
顺序队列使用数组来实现

链式队列使用链表来实现

顺序队列的长度固定 超过长度要对数组进行扩容
链式队列的是无限长度的但是出队入队相对比较慢占用内存空间大

### 循环队列
相比较普通的顺序队列 出队入队之后会有一个数据搬移的过程，所以这里引出一个循环队列的概念

循环队列，
顾名思义，
它长得像一个环。
原本数组是有头有尾的，
是一条直线。
现在我们把首尾
相连，
扳成了一个环。
但是循环队列会浪费一个空间来放置尾节点

用代码来实现一下循环队列
```
type Object interface { }

// len 表示我们用于储存数据的数组的长度
var len int

/*
Queue 队列
 */
type Queue struct {
	data []Object
	head int // 头节点
	tail int // 尾节点
}

// 初始化队列
func InitCircleQueue(size int) Queue {
	len = size + 1
	array := make([]Object, len)
	q := Queue{}
	q.data = array
	q.head = 0
	q.tail = 0
	return q
}

// 判断是否为空
func (q *Queue) IsEmpty() bool {
	if q.head == q.tail {
		return true
	}
	return false
}

// 循环队列是否满了
func (q *Queue) IsFull() bool {
	next := q.GetTailNext()
	if next == q.head {
		return true
	}
	return false
}

// 获取下一个插入队列的位置
func (q *Queue) GetTailNext() (next int) {
	fmt.Println("tail:", q.tail)
	if q.tail == len - 1 {
		next = 0
		return
	}
	next = q.tail + 1
	return
}

// Push
func (q *Queue) Push(data Object) (err error) {
	cur := q.tail
	if q.IsFull() {
		fmt.Println("队列已满， 无法继续添加")
		return errors.New("队列已满， 无法继续添加")
	}
	q.data[cur] = data

	if q.tail == len -1 {
		q.tail = 0
	} else {
		q.tail++
	}
	fmt.Println("添加元素成功：", data)
	return nil
}

// Pop
func (q *Queue) Pop() Object {
	if q.IsEmpty() {
		fmt.Println("队列为空，无法继续弹出")
		return nil
	}
	head := q.head
	// head 后移
	if head == len-1 {
		q.head = 0
	} else {
		q.head++
	}
	// 取出元素
	data := q.data[head]
	// head位置清空
	q.data[head] = nil
	fmt.Println("数据取出:", data)
	return data
}

func (q *Queue) ShowQueue() {
	array := q.data
	for i:=0;i<len;i++ {
		fmt.Printf("下标为%d的元素为%v \n", i, array[i])
	}
}
```