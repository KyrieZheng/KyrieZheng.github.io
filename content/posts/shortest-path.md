---
title: "最短路径问题"
date: 2021-08-10T10:10:42+08:00
---

```
一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为“Start")
机器人每次只能向下或者向右移动一步。机器人试图达到王哥的右上角（在图中标记为“Finssh”）
总共有多少条不同的路径？
```
![robot](https://assets.leetcode.com/uploads/2018/10/22/robot_maze.png)
[leetCode62](https://leetcode-cn.com/problems/unique-paths/)

```
func UniquePaths(m, n int) int {
	dp := make([][]int, m)
	// 第一列只有一条途径
	for i := range dp {
		dp[i] = make([]int, n)
		dp[i][0] = 1
	}
	// 第一行只有一条路径
	for j := 0;j < n;j++ {
		dp[0][j] = 1
	}

    //动态规划表达式
	for i:=1;i<m;i++ {
		for j:=1;j<n;j++ {
			dp[i][j] = dp[i-1][j] + dp[i][j-1]
		}
	}
	return dp[m-1][n-1]
}
```


