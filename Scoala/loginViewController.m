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

-(NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}


- (IBAction)bla:(id)sender {
    
    [self performSegueWithIdentifier:@"blaSegue" sender:nil];
}
//functie care ar trebui sa implementeze cautarea emailului si a parolei in baza de date
//si sa returneze id-ul userului care s-a logat
-(int) checkUser:(NSString*) nume
             and:(NSString*) parola


{
    
    //aplic codificare sha-1 pentru parola
    NSString *pass_sha=[self sha1:parola];


    //construiesc hyperlink-ul pentru conectarea la server
    
    NSString *string_auxiliar=[NSString stringWithFormat:@"http://89.149.34.98:85/catalog/login?email=%@&password=%@",
                               nume,pass_sha];
    
    //cere catre server
    NSURLRequest *cerere=[NSURLRequest requestWithURL:[NSURL URLWithString:string_auxiliar]];
    //primesc raspunsul la cererea sincrona
    NSData *raspuns=[NSURLConnection sendSynchronousRequest:cerere returningResponse:nil error:nil];
    
    NSError *eroareJson=nil;
    
    //transform raspunsul din clasa generica NSData intr-un sir specific formatat ca dictionar conform jsonului
    NSArray *users = [NSJSONSerialization JSONObjectWithData:raspuns options:0 error:&eroareJson];
    
    NSDictionary *user;
    
    // !!!!!!! De verificat ca raspunsul e nul
    
    //iau primul rezultat din json si campul id il returnez
    
    if([users count]==0)
        return 0;
    else
    {
    
    user=[users objectAtIndex:0];
    NSLog(@"id user:%@",[user objectForKey:@"id"]);
    NSString * idUserAsString=[user objectForKey:@"id"];
    
    //convertesc la int si returnez
    return [idUserAsString integerValue];
    }
    
}
- (IBAction)CheckPass:(id)sender {
    
    
    int user=[self checkUser:self.EmailText.text and:self.PassText.text]; // verific user si parola si primesc inapoi un Id
    NSUserDefaults *UserID = [NSUserDefaults standardUserDefaults];
    database * db_connect=[[database alloc]init];

    
    
    if(user!=0) // daca exista userul
    {
        //self.LabelDeMesaje.Text=@"Date de autentificare corecte";
        
        //NSArray * copii=[db_connect getChild:[NSString stringWithFormat:@"%d",user]];
        
        //Verificam ca un parinte are cel putin un copil inscris in scoala ...
        //!!!! Comentat in scopuri de testare
        
        /*if([copii count]==0)
        {
            
            UIAlertView *Mesaj=[[UIAlertView alloc] initWithTitle:@"Eroare!" message:@"Nu aveti nici un copil care urmeaza cursurile la aceasta scoala!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [Mesaj show];
            return;
        }
        
        
        
        NSString *id_copil=[[copii objectAtIndex:0]objectForKey:@"id"];
 
        [UserID setObject:id_copil forKey:@"IDCopil"];
        
        */
        [UserID setInteger:user	 forKey:@"cheieUser"];
        
        [self performSegueWithIdentifier:@"toMaterii" sender:nil];

    }
    
    else
    {
        UIAlertView *Mesaj=[[UIAlertView alloc] initWithTitle:@"Eroare!" message:@"Ati gresit datele de autentificare!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [Mesaj show];
        //self.LabelDeMesaje.text=@"Ati gresit datele de autentificare";
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



}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger  checkUserId=[prefs integerForKey:@"cheieUser"];
    
    if(checkUserId==0) self.LabelDeMesaje.text=@" nu am pastrat id"; //afisare pentru testarea functionalitatii NSUserDefaultss
    else
    {//self.LabelDeMesaje.text=@" Hooooray";
     [self shouldPerformSegueWithIdentifier:@"toMaterii"  sender:nil];    }

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
