//
//  AddContactViewController.swift
//  MyContacts
//
//  Created by Pivotal on 5/23/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit
import Contacts

protocol AddContactViewControllerDelegate {
    func didFetchContacts(contacts: [CNContact])
}


class AddContactViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: AddContactViewControllerDelegate!
    
    let txtLastName : UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        AppDelegate.getAppDelegate().requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                let predicate = CNContact.predicateForContactsMatchingName(self.txtLastName.text!)
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey]
                var contacts = [CNContact]()
                var message: String!
                
                let contactsStore = AppDelegate.getAppDelegate().contactStore
                do {
                    contacts = try contactsStore.unifiedContactsMatchingPredicate(predicate, keysToFetch: keys)
                    
                    if contacts.count == 0 {
                        message = "No contacts were found matching the given name."
                    }
                }
                catch {
                    message = "Unable to fetch contacts."
                }
                
                if message != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        AppDelegate.getAppDelegate().showMessage(message)
                    })
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate.didFetchContacts(contacts)
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                }
            }
        }
        
        return true
    }
}
