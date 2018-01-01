//
//  ViewController.swift
//  User Login
//
//  Created by burak on 1.01.2018.
//  Copyright © 2018 Burak Yıldırım. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    

    @IBAction func signUpClicked(_ sender: Any) {
        
        if username.text != "" && password.text != "" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let insert = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            fetch.returnsObjectsAsFaults = false
            fetch.predicate = NSPredicate(format: "username = %@", username.text!)
            
            do {
                let users = try context.fetch(fetch)
                // This username already received ?
                if users.count > 0 {
                    let alert = UIAlertController(title: "Error", message: "Unfortunately this username has already been taken !", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // User registered
                    insert.setValue(username.text!, forKey: "username")
                    insert.setValue(password.text!, forKey: "password")
                    
                    try context.save()
                    
                    let alert = UIAlertController(title: "Sign Up", message: "You signed up", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            } catch {
                
            }
            
        } else {
            // İf the user has empty field
            let alert = UIAlertController(title: "Error", message: "Please fill empty field !", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if username.text != "" && password.text != "" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            fetch.returnsObjectsAsFaults = false
            fetch.predicate = NSPredicate(format: "username = %@", username.text!)
            
            do {
                let results = try context.fetch(fetch)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let userPassword = result.value(forKey: "password") as? String {
                            
                            if userPassword == password.text {
                                // If pair username and password is correctly ?
                                let alert = UIAlertController(title: "Log In", message: "You logged in", preferredStyle: UIAlertControllerStyle.alert)
                                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                                alert.addAction(ok)
                                self.present(alert, animated: true, completion: nil)
                                
                            } else {
                                // Wrong password alet
                                let alert = UIAlertController(title: "Error", message: "Please check your entered field !", preferredStyle: UIAlertControllerStyle.alert)
                                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                                alert.addAction(ok)
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                            
                        }
                    }
                } else {
                    // is the wrong username
                    let alert = UIAlertController(title: "Error", message: "No such user found !", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            } catch {
                
            }
            
        } else {
            // İf the user has empty field
            let alert = UIAlertController(title: "Error", message: "Please fill empty field !", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
}

