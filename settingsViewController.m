//
//  settingsViewController.m
//  Scoala
//
//  Created by CLEVERSOFT-2 on 11/6/13.
//  Copyright (c) 2013 CLEVERSOFT-2. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView * SelectCopii;



@end

@implementation settingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    database * db_connect=[[database alloc]init];
    NSArray * date_copii =[db_connect getChild:@"331"];
    
    NSMutableArray * Aux_NumeCopii=[[NSMutableArray alloc]init];
    NSMutableArray * Aux_IdCopii=[[NSMutableArray alloc] init];
    
    for(int i=0;i<[date_copii count];i++)
    {
        NSString *Nume_copil=[[date_copii objectAtIndex:i] objectForKey:@"first_name"];
        NSString *Prenume_copil=[[date_copii objectAtIndex:i]
                                 objectForKey:@"last_name"];
        
        NSString *Id_copil=[[date_copii objectAtIndex:i] objectForKey:@"id"];
        
        [Aux_NumeCopii addObject:[NSString stringWithFormat:@"%@ %@",Nume_copil,Prenume_copil]];
        [Aux_IdCopii addObject:Id_copil];
        
    }
    
    _NumeCopii=Aux_NumeCopii;
    _IdCopii=Aux_IdCopii;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *) SelectCopii
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *) SelectCopii
numberOfRowsInComponent:(NSInteger)component
{
    return _NumeCopii.count;
}

- (NSString *)pickerView:(UIPickerView *) SelectCopii
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _NumeCopii[row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSUserDefaults * prefs=[NSUserDefaults standardUserDefaults];
    [prefs setObject:_IdCopii[row] forKey:@"IDCopil"];
    
    NSString *aux_string=[NSString stringWithFormat:@"De acum vei vedea notele si mesajele pentru: %@ (ID=%@ )", _NumeCopii[row],_IdCopii[row]];
    UIAlertView *Mesaj=[[UIAlertView alloc] initWithTitle:@"Atentie!" message:aux_string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [Mesaj show];}
@end
