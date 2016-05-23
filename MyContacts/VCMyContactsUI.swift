//
//  VCMyContactsUI.swift
//  MyContacts
//
//  Created by Pivotal on 5/23/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit
import Contacts

class VCMyContactsUI: UITableViewController {
    
    //@IBOutlet var tableView:UITableView?
    var objects = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func insertNewObject(sender: NSNotification) {
        if let contact = sender.userInfo?["contactToAdd"] as? CNContact {
            objects.insert(contact, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func onShowContacts(sender:AnyObject){
        getContacts()
    }
    
    // MARK: - Contacts
    func getContacts() {
        let store = CNContactStore()
        
        if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined {
            store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
                if authorized {
                    self.retrieveContactsWithStore(store)
                }
            })
        } else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized {
            self.retrieveContactsWithStore(store)
        }
    }
    func retrieveContactsWithStore(store: CNContactStore) {
        do {
            //let groups = try store.groupsMatchingPredicate(nil)
            //let predicate = CNContact.predicateForContactsInGroupWithIdentifier(groups[0].identifier)
            //let predicate = CNContact.predicateForContactsMatchingName("John")
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey]
            //let contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            
            // ref : https://fullstackpug.wordpress.com/2015/09/20/ios-9-contacts-framework-get-all-contacts/
            let containerId = CNContactStore.defaultContainerIdentifier(store)
            let predicate = CNContact.predicateForContactsInContainerWithIdentifier(containerId())
            let contacts = try store.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            //
            
            self.objects = contacts
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath: indexPath)
        
        let contact = self.objects[indexPath.row]
        let formatter = CNContactFormatter()
        
        cell.textLabel?.text = formatter.stringFromContact(contact)
        cell.detailTextLabel?.text = contact.emailAddresses.first?.value as? String
        
        return cell
    }
}
