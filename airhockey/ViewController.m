//
//  ViewController.m
//  airhockey
//
//  Created by Chen Li Te on 2013/12/17.
//  Copyright (c) 2013年 mobiusdesign. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    IBOutlet UIImageView *handleImageView1;
    IBOutlet UIImageView *handleImageView2;
    IBOutlet UIImageView *ballImageView;
    
    float speed;
    float direct;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    speed=5.0f;
    direct=0.3;
    NSTimer *timer;
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.01
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.view];

    if(point.y<480/2){
        [handleImageView1 setCenter:point];
    }else{
        [handleImageView2 setCenter:point];
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.view];
    if(point.y<480/2){
        [handleImageView1 setCenter:point];
    }else{
        [handleImageView2 setCenter:point];
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.view];
    
    if(point.y<480/2){
        [handleImageView1 setCenter:point];
    }else{
        [handleImageView2 setCenter:point];
    }
}


- (void) handleTimer: (NSTimer *) timer
{
    CGPoint p=ballImageView.center;
    p.x=p.x+speed*cos(direct*M_PI);
    p.y=p.y+speed*sin(direct*M_PI);
    
    if(p.y<46/2){
        direct=-direct;
        p.y=46/2;
    }
    if(p.y>480-46/2){
        direct=-direct;
        p.y=480-46/2;
    }
    
    if(p.x<46/2){
        direct=1-direct;
        p.x=46/2;
    }
    if(p.x>320-46/2){
        direct=1-direct;
        p.x=320-46/2;
    }

    float distance;
    float tempdirect;
    distance=[self checkDistance:ballImageView.center withPoint:handleImageView1.center];
    if(distance<40){
        float line=[self checkATAN:ballImageView.center withPoint:handleImageView1.center];
        direct=-1*direct-(line-0.5);

        tempdirect=[self checkATAN:ballImageView.center withPoint:handleImageView1.center];
        [ballImageView setCenter:CGPointMake(70*cos(tempdirect), 70*sin(tempdirect))];
    }
    distance=[self checkDistance:ballImageView.center withPoint:handleImageView2.center];
    if(distance<40){
        float line=[self checkATAN:ballImageView.center withPoint:handleImageView2.center];
        direct=-1*direct-(line-0.5);
        
        tempdirect=[self checkATAN:ballImageView.center withPoint:handleImageView1.center];
        [ballImageView setCenter:CGPointMake(70*cos(tempdirect), 70*sin(tempdirect))];
    }
    
    
    
    
    
    
    
    [ballImageView setCenter:p];
    
}
-(float)checkDistance:(CGPoint)point1 withPoint:(CGPoint)point2{
    return sqrt(pow((point1.x-point2.x),2)+pow((point1.y-point2.y),2));
}
-(float)checkATAN:(CGPoint)point1 withPoint:(CGPoint)point2{
    return atan2(point1.y-point2.y,point1.x-point2.x);
}

@end
