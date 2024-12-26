
## A 在行尾插入字符
## I insert at beginning of the line

## :vs :vp 分屏

## :% s/foo/bar/g 全局切换 %全部文件

## 大写 V 选中整个行
## ctrl v 进行方块选择
## v 选中后可以 x/d删除选中

## ctrl+h 删除上一个字符
## ctrl+w 删除上一个单词
## ctrl+u 删除当前行

## 以上3个用法在 shell 命令行也可以使用,并且：
### ctrl a 开头 ctrl e 结尾 (oh-my-zsh 不行
### ctrl b f 前后移动

## quick shift between insert & normal
### 插入模式下 ctrl + c / ctrl + [ 替代 esc ,前者会中断某些插件
### 普通模式下:用gi跳转到最后一次编辑的地方，并进入插入模式
### 推荐 hhkb poker这种键盘，还有能改键的键盘

## vim 快速移动方法

### w/W e/E 单词开头，结尾
### b/B 回到开头
### w - 非空白符分割的单词，W 以空白符分割的单词

```python
self.name = name
# w 从self跳到 name
# W 从self 跳到 =(以空格为分割
```

### :syntax on 打开语法高亮

## 行间搜索
### f{char}移动到 char 字符上面，t移动到 char前面一个字符
### 分号 逗号 搜索上一个，下一个
### 大写 F 反过来搜索前面的字符，从后往前搜索

## vim 水平移动
### 0移动到行首第一个字符，^移动到第一个非空白字符
### $ to tail, g_ to tail (non blank char)

## {}段落移动 ()句子间移动
### :help ( 查看帮助

## ctrl + o back to last position
## H/M/L 跳转到屏幕开头，中间，结尾
## ctrl +u +f 上下翻页，zz 把屏幕置为中间爱你