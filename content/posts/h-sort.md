---
title: "堆排序 && 堆的应用"
date: 2021-07-30T16:53:30+08:00
---
## 堆
#### 什么是堆？？
堆的定义 

- 堆是一种完全二叉树，完全二叉树的形式是指除了最后一层之外，其他所有层的结点都是满的，而最后一层的所有结点都靠左边
- 堆中的每一个节点的值需要大于等于（或者小于等于）其子树的每一个节点

![42676-0955fabfb52c11db](https://user-images.githubusercontent.com/34566156/153533413-64762bb9-e087-4430-824c-0e56a1eb0213.png)

#### 如何实现一个堆
- 每个节点的值都大于等于其子树的称为大顶堆
- 每个节点的值都小于等于其子树的称为小顶堆

- 可以使用数组来表示堆 因为堆是一个完全二叉树 满足节点i的子树为2*i 和 2*i + 1 可以使用数组表示一个堆

##### Show Code
```
type Heap struct {
	M   []int
	Len int
}

// BuildHeap 对数组进行堆化
func BuildHeap(array []int) *Heap {
	m := make([]int, 1)
	m = append(m, array...)
	n := len(m) - 1
	for i := n / 2; i > 0; i-- {
		heapF(m, n, i)
	}
	return &Heap{
		M:   m,
		Len: n,
	}
}

// 堆节点堆化
func heapF(m []int, n, i int) {
	for {
		maxPos := i
		if 2*i <= n && m[2*i] > m[i] {
			maxPos = 2 * i
		}
		if 2*i+1 <= n && m[2*i+1] > m[maxPos] {
			maxPos = 2*i + 1
		}
		if maxPos == i { //如果i节点位置正确，则退出
			break
		}
		m[i], m[maxPos] = m[maxPos], m[i]
		i = maxPos
	}
}

func (h *Heap) Insert(data int) {
	h.M = append(h.M, data)
	h.Len++
	i := h.Len
	for i/2 > 0 && h.M[i/2] < h.M[i] {
		h.M[i/2], h.M[i] = h.M[i], h.M[i/2]
		i = i / 2
	}
}

// Delete 删除堆顶元素
func (h *Heap) Delete() {
	// 删除堆顶元素
	if h.Len < 1 {
		return
	}

	h.M[1] = h.M[h.Len]
	h.M = h.M[:h.Len]
	h.Len--
	heapF(h.M, h.Len, 1)
}
```

#### 堆排序
通过堆的概念 就可以使用堆排序进行排序了
- 堆顶的数是最大值
- 每次取出堆中最大值后，进行出堆 堆化操作

```
func HeapSort(array []int) []int {
	// 对数组堆化 大顶堆
	sortA := make([]int, 0)
	heapI := heap.BuildHeap(array)
	len := heapI.Len
	for len > 0 {
		sortA = append(sortA, heapI.M[1])
		heapI.Delete()
		len = heapI.Len
	}
	return sortA
}
```

#### 堆的应用

##### 计算TopK
- 利用堆实现一个优先级队列，实现一个小顶堆
- 先将数组的前k个数据进行堆化
- 对剩下的数组遍历与堆顶数据比较在进行堆化
- 只要维护这一个大小为k的小顶堆 这个堆中的数据就是前TopK

```
func TopK(array []int, k int) []int {
	len := len(array)
	if k > len {
		fmt.Println("k的值大于数组长度")
		return nil
	}

	// 生成大小为k的小顶堆
	heapArr := array[:k]
	smallHeap := BuildSmallHeap(heapArr)
	Insert(smallHeap, array[k:])
	return smallHeap.M
}

func BuildSmallHeap(array []int) *heap.Heap {
	m := make([]int, 1)
	m = append(m, array...)
	len := len(m) - 1
	fmt.Println(len)
	i := len / 2
	for ; i > 0; i-- {
		smallHeap(m, len, i)
	}
	return &heap.Heap{m, len}
}

func smallHeap(array []int, len, i int) {
	for {
		fmt.Println(i)
		minIndex := i
		if i*2 <= len && array[i*2] < array[i] {
			minIndex = i * 2
		}
		if 2*i+1 <= len && array[2*i+1] < array[minIndex] {
			minIndex = i*2 + 1
		}
		if minIndex == i {
			break
		}
		array[minIndex], array[i] = array[i], array[minIndex]
		i = minIndex
	}
}

func Insert(heap *heap.Heap, m []int) {
	// 插入堆中 如果满足则替换堆顶 并重新堆化
	len := len(m)
	for len > 0 {
		if m[0] > heap.M[1] {
			// 替换
			heap.M[1] = m[0]
			smallHeap(heap.M, heap.Len, 1)
		}
		m = m[1:]
		len--
	}
}

func main() {
    m := []int{3, 5, 1, 2, 8, 6, 10, 12, 7, 1}
	fmt.Println(sort.TopK(m, 5))
}
```
