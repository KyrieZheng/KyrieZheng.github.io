---
title: "反转链表如何实现？"
date: 2021-07-15T16:04:53+08:00
---

# 链表

### 实现链表反转
```
type ListNode struct {
    Val int
    Next *ListNode
}

func ReverseList(head *ListNode) *ListNode {
    if head == nil {
       return nil
    }

    var newHead *ListNode
    for head != nil {
        node := head.Next
        head.Next = newHead
        newHead = head
        head = node
    }

    return newHead
}

func FormatNode(head *ListNode) string {
    if head == nil {
        return "nil"
    }

    returnNode := ""
    for head != nil {
        stringNode := head.Val
        returnNode =  returnNode + strconv.Itoa(stringNode) + "->"
        head = head.Next
    }

    return returnNode
}
```

### 分析反转链表的实现

短短几行代码就很巧妙的实现了反转链表

```
var newHead *ListNode
```
先定义一个新的链表
```
head != nil
```
循环结束条件

```
node := head.Next
```
取出当前链表头节点的子节点
```
head.Next = newHead
```
可以发现每次循环都可以把当前的头节点和上一次循环的头节点连接起来

```
比如 1->2->3->4->5
第一次循环结束
newHead: 1->
head: 2->3->4->5->
第二次循环结束
newHead: 2->1->
head: 3->4->5->
···
```
