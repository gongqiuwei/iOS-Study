# iOS-Study
记录一些iOS学习的知识点，这里只是目录，具体看demo中的总结或者.md文件

## iOS9 OC新语法
- `nullable` \ `nonnull` 
- `NS_ASSUME_NONNULL_BEGIN` 与 `NS_ASSUME_NONNULL_END` 宏 
-  `null_resettable`
-  泛型（使用、自定义泛型、协变性和逆变性）

## runtime相关
- 消息机制 `objc_msgSend`
- 方法交换实现方式 `method_exchangeImplementations`
- 消息转发机制（动态添加方法）
- 动态添加属性
- 模型转换

## super self superclass
- 参考 <http://blog.jobbole.com/79588/>
- super只是一个编译修饰符
- [super class] 输出是当前哪个类调用输出哪个
	
  ```
  0、[super xxxMethod] 当编译器看到super调用时，消息发送调用的方法不再是objc_msgSend而是objc_msgSendSuper函数
  
  1、OC中每个方法都有2个隐士参数 id self 和 SEL _cmd, 前者是调用者对象，后者是这个方法的SEL选择器
  
  2、struct objc_super { id receiver; Class superClass; };
  // receiver是消息的实际接收者，传入的是self指向的对象
  // superClass当前对象的父类， self的superClass
  
  id objc_msgSendSuper ( struct objc_super *super, SEL op, ... );
  // 该函数第一个参数即为前面生成的objc_super结构体，第二个参数是方法的selector。
  // 该函数实际的操作是：从objc_super结构体指向的superClass的方法列表开始查找xxxMethod的selector，找到后以objc->receiver去调用这个selector，而此时的操作流程就是如下方式了:objc_msgSend(objc_super->receiver, @selector(viewDidLoad))
  
  ```