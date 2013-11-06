//
//  materiiViewController.m
//  Scoala
//
//  Created by CLEVERSOFT-2 on 10/25/13.
//  Copyright (c) 2013 CLEVERSOFT-2. All rights reserved.
//

#import "materiiViewController.h"
#import "loginViewController.h"

@interface materiiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UITextView *TextViewDeAfisat;

@end

@implementation materiiViewController



- (IBAction)actiune:(id)sender {
    
    
   /* loginViewController * unu=[[loginViewController alloc] init];
    [self.navigationController pushViewController:unu animated:YES];*/
}
- (IBAction)dezinitializeaza:(id)sender {
    NSUserDefaults *UserID = [NSUserDefaults standardUserDefaults];
     [UserID setInteger:0	 forKey:@"cheieUser"];
    [UserID setObject:0  forKey:@"IDCopil"];
    [self performSegueWithIdentifier:@"toLogin" sender:nil];


}
- (IBAction)verificaFunctie:(id)sender {
    
   
    database * db_connect=[[database alloc]init];
    NSArray * materii;
    
    //materii=[db_connect getMarks:@"185"];
    materii=[db_connect getChild:@"209"];
    //materii=[db_connect getNews];
    //materii=[db_connect getMaterii];


    
    for(int i=0;i<[materii count];i++)
    {
        self.TextViewDeAfisat.text=[NSString stringWithFormat:@"%@ %@ \n",self.TextViewDeAfisat.text,[[materii objectAtIndex:i] objectForKey:@"id"]];
        
        
    }
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // a se pune aici instructiuni pentru a se executa la incarcarea view-ului .
    // NU in : WILLAppear, DidLoad etc
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger  checkUserId=[prefs integerForKey:@"cheieUser"];
  // iau cheia userului din UserDefaults
    if(checkUserId==0)
    {    self.Label.text=@"nu e initializat";
        [self performSegueWithIdentifier:@"toLogin" sender:nil]; //daca nu exista deschid ecranul de login
    }
    else
        self.Label.text=@"e initializat";
    //altfel raman pe acelasi view
    

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
  
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
