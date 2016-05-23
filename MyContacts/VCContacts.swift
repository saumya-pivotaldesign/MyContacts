//
//  VCContacts.swift
//  MyContacts
//
//  Created by Pivotal on 5/23/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit

import ContactsUI

class VCContacts: UIViewController , UITextFieldDelegate, UIPickerViewDelegate, CNContactPickerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
        
    }
    
    
    @IBAction func showContacts(sender: AnyObject) {
        showNativeContactsUI()
    }
    
    // displaying Native Contacts UI
    private func showNativeContactsUI(){
        let contactPickerViewController = CNContactPickerViewController()
        //contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "birthday != nil")
        contactPickerViewController.delegate = self
        presentViewController(contactPickerViewController, animated: true, completion: nil)
    }
}