---
title: "JavaScript 中的箭头函数"
date: 2021-06-20T23:37:46+08:00
comments: true
---

### 箭头函数1
- this 是静态的 使用call 也无法改变
```bash
function getName() {
    console.log(this.name)
}

let getName2 = () => {
    console.log(this.name)
}

window.name = '111'
let school = {
    name: '222'
}

getName.call(school) // 222
getName2.call(school) // 111
```
- 不能当作构造函数
```bash
let Person = (name, age) => {
    this.name = name;
    this.age = age
}

let xiaoming = new Person('xiaoming', 18) // 报错
```

- 不能使用arguments 变量
```bash
let fn = () => {
    console.log(arguments)
} // arguments is not defined
```

