# KLTextView
支持 placeholder占位文字和字数限制的 TextView
## 完美封装，无缝对接UITextView
***
## 常规功能
设置占位符与输入字数限制
usage
- 
	KLTextView *textView = [[KLTextView alloc]initWithFrame:CGRectMake(10, 200, 375-20, 200)];
    textView.backgroundColor = [UIColor lightGrayColor];
    textView.placeholder = @"今日的心得或者想说的话";
    textView.limitNum = 200;
    [self.view addSubview:textView];

![image](https://github.com/kouliang/KLTextView/blob/master/gif/1-常规功能.gif)
***
## 在xib中使用KLTextView
![image](https://github.com/kouliang/KLTextView/blob/master/gif/xib1.png)

![image](https://github.com/kouliang/KLTextView/blob/master/gif/xib2.png)
***
## 设置字体
usage
-
	textView.textColor = [UIColor blueColor];
    textView.font = [UIFont systemFontOfSize:20];
![image](https://github.com/kouliang/KLTextView/blob/master/gif/2-设置字体.gif)
***
## 设置内边距
usage
-
	textView.textContainerInset = UIEdgeInsetsMake(10, 20, 10, 20);
![image](https://github.com/kouliang/KLTextView/blob/master/gif/3-设置内边距.gif)
***
## 设置对齐方式
usage
-
	textView.textAlignment = NSTextAlignmentRight;
![image](https://github.com/kouliang/KLTextView/blob/master/gif/4-设置对齐方式.gif)
***
### 设置代理方法
usage
-
	textView.delegate = self;
![image](https://github.com/kouliang/KLTextView/blob/master/gif/5-设置代理.gif)
