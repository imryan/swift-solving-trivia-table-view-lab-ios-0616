//
//  StatesTableViewController.swift
//  swift-solving-trivia-table-view-lab
//
//  Created by Ryan Cohen on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class StatesTableViewController: UITableViewController {
    
    let data = States()
    
    var states: [String] = []
    
    // MARK: - Functions
    
    func alert(state: String, capital: String) {
        let trivia = containsCharacter(state, capital: capital)
        let message = (trivia) ? "\(capital) and \(state) share letters." : "\(capital) and \(state) share no letters."
        
        let alertController = UIAlertController(title: "\(capital), \(state)", message: message, preferredStyle: .Alert)
        
        let dismiss = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        
        alertController.addAction(dismiss)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func containsCharacter(state: String, capital: String) -> Bool {
        var contains = false
        
        for c: Character in capital.characters {
            if (state.characters.contains(c)) {
                contains = true
            }
        }
        
        return contains
    }

    // MARK: - Table

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "States"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.statesAndCapitals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellId", forIndexPath: indexPath)

        let state = states[indexPath.row]
        let capital = data.statesAndCapitals[state]!
        
        cell.textLabel?.text = state
        cell.detailTextLabel?.text = capital

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let state = states[indexPath.row]
        let capital = data.statesAndCapitals[state]!
        
        alert(state, capital: capital)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        states = Array(data.statesAndCapitals.keys)
        
        let sort = NSSortDescriptor(key: "", ascending: true)
        states = (states as NSArray).sortedArrayUsingDescriptors([sort]) as! [String]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}