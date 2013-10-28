//
//  loginViewController.m
//  Scoala
//
//  Created by CLEVERSOFT-2 on 10/25/13.
//  Copyright (c) 2013 CLEVERSOFT-2. All rights reserved.
//

#import "loginViewController.h"
#import "materiiViewController.h"

@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *EmailText;
@property (weak, nonatomic) IBOutlet UITextField *PassText;
@property (weak, nonatomic) IBOutlet UILabel *LabelDeMesaje;

@end

@implementation loginViewController
- (IBAction)bla:(id)sender {
    
    [self performSegueWithIdentifier:@"blaSegue" sender:nil];
}
//functie care ar trebui sa implementeze cautarea emailului si a parolei in baza de date
//si sa returneze id-ul userului care s-a logat
-(int) checkUser:(NSString*) nume
             and:(NSString*) parola


{
    if( [nume isEqualToString:@"parinte"] && [parola isEqualToString:@"parola"])
        return 1;
    
    
    return 0;
}
- (IBAction)CheckPass:(id)sender {
    
    
    int user=[self checkUser:self.EmailText.text and:self.PassText.text]; // verific user si parola si primesc inapoi un Id
    NSUserDefaults *UserID = [NSUserDefaults standardUserDefaults];
    if(user!=0) // daca exista userul
    {
        self.LabelDeMesaje.Text=@"Date de autentificare corecte";
        
        [UserID setInteger:user	 forKey:@"cheieUser"];
        
        [self performSegueWithIdentifier:@"toMaterii" sender:nil];
        // setez UserDefault-ul cu numele cheieUser ca fiind
        
        /*materiiViewController * doi = [[materiiViewController alloc] init];
        [self.navigationController 	pushViewController:doi animated:YES];*/
        /*UIStoryboard * sb=[UIStoryboard 	storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc=[	sb instantiateViewControllerWithIdentifier:@"materiiSB"];
        [self presentViewController:vc animated:YES completion:nil];*/
    }
    
    else
    {
        self.LabelDeMesaje.text=@"Ati gresit datele de autentificare";
        [UserID setInteger:user	 forKey:@"cheieUser"]; //daca nu sunt bune datele de autentificare setez UserDefault-ul sa fie 0
    }
}

- (BOOL) textFieldShouldReturn:(UITextField*) EmailText
{//pentru disparitia tastaturii...+ creare delegate la textfield CTRL+ drag pe cercu galben
    
    
    [self.EmailText resignFirstResponder];
    [self.PassText  resignFirstResponder];
    
    return YES;
}



- (void)viewWillAppear:(BOOL)animated
{

    
   /* UIAlertView *a =[[UIAlertView alloc] initWithTitle:@"ViewWillAppear" message:@"a aparut " delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
       [a show];*/




}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger  checkUserId=[prefs integerForKey:@"cheieUser"];
    
    if(checkUserId==0) self.LabelDeMesaje.text=@" nu am pastrat id"; //afisare pentru testarea functionalitatii NSUserDefaultss
    else
    {self.LabelDeMesaje.text=@" Hooooray";
     [self shouldPerformSegueWithIdentifier:@"toMaterii"  sender:nil];    }

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
