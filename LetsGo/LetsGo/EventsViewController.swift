//
//  EventsViewController.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-12-01.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit
import MapKit
class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var eventsTable: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var Events: [Event]?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
     
        
        searchTextField.delegate = self
        searchTextField.layer.cornerRadius = 8
        searchTextField.layer.masksToBounds = false
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchTextField.layer.shadowRadius = 15
        searchTextField.layer.shadowColor = UIColor.black.cgColor
        searchTextField.layer.shadowOffset = CGSize(width: 1.0,height: 1.0)
        
        searchTextField.layer.shadowOpacity = 1.0
        
        if Events == nil {
           
            initTable(searchValue: "")
            
        }
        // Do any additional setup after loading the view.
        eventsTable.delegate = self
        eventsTable.dataSource = self
       
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        initTable(searchValue: textField.text!)
        eventsTable.reloadData()
    }
    
    func initTable(searchValue: String) {
        var locManager = CLLocationManager()
        
        let sem = DispatchSemaphore(value: 0)
        
        var currentLocation: CLLocation! {
            didSet {
                sem.signal()
            }
        }
        
    
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways ) {
            currentLocation = locManager.location
            sem.wait()
            print("Longitude: \(currentLocation.coordinate.longitude)")
            print("Lattitude: \(currentLocation.coordinate.latitude)")
            
        }
        
        let list = (thisUser.getEventsByProximity(longitude: currentLocation.coordinate.longitude, lattitude: currentLocation.coordinate.latitude,searchValue: searchValue) ?? nil)!
        var tempEvents = [Event]()
        
        for evid in list {
            let tempEvent = Event(ei: Event.getEventInfo(id: evid))!
            tempEvents.append(tempEvent)
            print("\(tempEvent.getTitle()!)")
            
        }
        Events = tempEvents
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        print("CHECK ME OUT")
        
        cell.load(Events![indexPath.row])
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.frame.origin.y -= 200
    }*/
    
    @objc func keyboardWillShow(notification: Notification) {
        /*if searchTextField.isEditing{
            self.view.window?.frame.origin.y = -1 * getKeyboardHeight(notification)
        }*/
       searchTextField.frame.origin.y -= 183
        //searchTextField.frame.origin.y =  1 *
        //(searchTextField.inputView?.frame.height)!
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        //searchTextField.frame.origin.y = -1 * (searchTextField.inputView?.frame.height)!
        if searchTextField.frame.origin.y < 600 {
            searchTextField.frame.origin.y = 603
        }
    }
    
   /* func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if searchTextField.frame.origin.y < 600 {
            searchTextField.frame.origin.y += 180
        }
    }*/
    
  

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
 
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        initTable(searchValue: "")
         eventsTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EventViewController {
            let next = segue.destination as! EventViewController
            let selectedEvent = sender as! EventTableViewCell
            guard let indexPath = eventsTable.indexPath(for: selectedEvent) else { print("Indexpath Error")
                return }
            
            next.event = Events![indexPath.row]
        }
    }

}
