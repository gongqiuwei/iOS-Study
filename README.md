# iOS-Study
记录一些iOS学习的知识点

## iOS9 OC新语法
- `nullable` \ `nonnull` 
- `NS_ASSUME_NONNULL_BEGIN` 与 `NS_ASSUME_NONNULL_END` 宏 
-  `null_resettable`
-  泛型（使用、自定义泛型、协变性和逆变性）

## runtime相关
- 概念解析
	- Class SEL IMP Method
		- Class
			- 在每一个类中都有一个Class类型的isa指针， 类指针
			- Class 被定义为一个指向 objc_class的结构体指针，这个结构体表示每一个类的类结构（我们可以理解为 **类对象**）
			- objc_class 在objc/objc_class.h中定义如下:
			
			```objc
			struct objc_class{
				struct objc_class super_class;  /*父类*/
				const char *name;   /*类名字*/
				long version;     /*版本信息*/
    			long info;    /*类信息*/
    			long instance_size;  /*实例大小*/
    			struct objc_ivar_list *ivars;     /*实例参数链表*/
    			struct objc_method_list **methodLists;  /*方法链表*/
    			struct objc_cache *cache;  /*方法缓存*/
    			struct objc_protocol_list *protocols;   /*协议链表*/
			} 
			```
			
		- Method
			- Method 在头文件 objc_class.h中定义
			
			```objc
			typedef struct objc_method *Method;
			
			typedef struct objc_ method {
    			SEL method_name; // 方法名称
    			char *method_types; // 该方法参数的类型
    			IMP method_imp; // 方法的实现地址
			};
			```
			
		- SEL
			- 表示方法的名字（例如：  setA:  等）
			- typedef struct objc_selector  *SEL;   
		
		- IMP
		   - SEL的方法具体实现的函数指针地址， 也就是代码块地址