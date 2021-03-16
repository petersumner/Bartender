//
//  ViewController.swift
//  Bartender
//
//  Created by Peter Sumner on 3/16/21.
//

import UIKit

class ViewController: UIViewController {

    //URL to our web service
    let URL_SAVE_TEAM = "http://192.168.1.2/WebService/api/createdrink.php"
    
    
    //TextFields declarations
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldMember: UITextField!

    
    //Button action method
    @IBAction func buttonSave(sender: UIButton) {
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(URL: requestURL!)
        
        //setting the method to post
        request.HTTPMethod = "POST"
        
        //getting values from text fields
        let drinkName=textFieldName.text
        let maker = textFieldMember.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "name="+drinkName!+"&ingredients={"Vodka": "1oz"}&garnish=NULL&creator="+maker!;
        //creating a task to send the post request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
                return;
            }
        
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
    }

}

