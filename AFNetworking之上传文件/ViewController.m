//
//  ViewController.m
//  AFNetworking之上传文件
//
//  Created by 陈高健 on 15/11/24.
//  Copyright © 2015年 陈高健. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//点击屏幕的时候上传文件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取基于NSURLSession的管理器
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    //上传文件
    NSDictionary *param=@{@"status":@"this is test"};
    [manager POST:@"http://localhost/post/upload-m.php" parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //获取文件1
        NSURL *url1=[[NSBundle mainBundle]URLForResource:@"01.jpg" withExtension:nil];
        [formData appendPartWithFileURL:url1 name:@"userfile[]" fileName:@"01.jpg" mimeType:@"image/png" error:NULL];
        //获取文件2
        NSURL *url2=[[NSBundle mainBundle]URLForResource:@"02.jpg" withExtension:nil];
        NSData *data2=[NSData dataWithContentsOfURL:url2];
        //[formData appendPartWithFileData:data2 name:@"userfile[]" fileName:@"02.jpg" mimeType:@"image/png"];
        //application/octet-stream通用格式
        [formData appendPartWithFileData:data2 name:@"userfile[]" fileName:@"02.jpg" mimeType:@"application/octet-stream"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"responseObject--->%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error---->%@",error);
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
