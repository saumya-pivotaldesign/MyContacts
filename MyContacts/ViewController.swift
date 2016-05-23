//
//  ViewController.swift
//  MyContacts
//
//  Created by Pivotal on 5/23/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit
import Contacts


// class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddContactViewControllerDelegate

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func didFetchContacts(contacts: [CNContact]) {
        for contact in contacts {
            self.contacts.append(contact)
        }
        
        //tblContacts.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        let cell = tableView.dequeueReusableCellWithIdentifier("idCellContactBirthday") as! ContactBirthdayCell
        
        let currentContact = contacts[indexPath.row]
        
        cell.lblFullname.text = "\(currentContact.givenName) \(currentContact.familyName)"
        
        
        // Set the birthday info.
        if let birthday = currentContact.birthday {
            cell.lblBirthday.text = "\(birthday.year)-\(birthday.month)-\(birthday.day)"
        }
        else {
            cell.lblBirthday.text = "Not available birthday data"
        }
        
        
        // Set the contact image.
        if let imageData = currentContact.imageData {
            cell.imgContactImage.image = UIImage(data: imageData)
        }
        
        
        // Set the contact's home email address.
        var homeEmailAddress: String!
        for emailAddress in currentContact.emailAddresses {
            if emailAddress.label == CNLabelHome {
                homeEmailAddress = emailAddress.value as! String
                break
            }
        }
        
        if homeEmailAddress != nil {
            cell.lblEmail.text = homeEmailAddress
        }
        else {
            cell.lblEmail.text = "Not available home email"
        }
        
        
        return cell
        */
        
        let cell = tableView.dequeueReusableCellWithIdentifier("idCellContactBirthday")
        return cell!
    }
   


}

