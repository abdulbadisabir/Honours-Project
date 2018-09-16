//
//  SearchAddressViewController.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-17.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//


import UIKit
import MapKit

class SearchAddressViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate,CLLocationManagerDelegate  {
    var searchController:UISearchController? = nil
    var mapView: MKMapView?
    let locationManager = CLLocationManager()
 
    
    override func viewDidLoad() {
        let backItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backAction))
      
        let doneItem = UIBarButtonItem(title: " Done", style: .plain, target: self, action: #selector(doneAction))
    
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationItem.rightBarButtonItem = doneItem
        
        
        let sourceTable = storyboard!.instantiateViewController(withIdentifier: "AddressSearch") as! SearchAddressTableViewController
       
        
        searchController = MySearchController(searchResultsController: sourceTable)
        searchController!.delegate = self
        searchController!.searchBar.delegate = self
        searchController?.searchResultsUpdater = sourceTable
        searchController!.searchBar.placeholder = "Search address"
        searchController!.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        searchController?.hidesNavigationBarDuringPresentation = false

        searchController!.definesPresentationContext = false
       
        searchController!.searchBar.sizeToFit()
       
       
        
        searchController!.definesPresentationContext = true
            searchController?.dimsBackgroundDuringPresentation = true
        
        searchController!.searchBar.setShowsCancelButton(false, animated: false)
        searchController!.searchBar.showsCancelButton = false
        
    
        mapView = MKMapView()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
       
        sourceTable.mapView = mapView!
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    
    
    
    override func viewDidAppear(_ animated: Bool) {
      //  super.viewDidAppear(animated)
        
   
        searchController!.isActive = true
       
        
        
      
    }
    
    
    func didPresentSearchController(_ searchController: UISearchController) {
      
      
       //Fixes a small bug as this method gets called before the search control is actually loaded into the view.
        UIView.animate(withDuration: 0.1, animations: { () -> Void in }) { (completed) -> Void in
            
           self.searchController!.searchBar.becomeFirstResponder()
        }
       
        
    }
    
    
 
    
   
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @objc func doneAction() {
       let table = searchController?.searchResultsUpdater as! SearchAddressTableViewController
       //self.address = table.address
       
        guard let controllers = self.navigationController?.viewControllers else {return}
      
        let prev = controllers[controllers.count - 2] as! CreateEventViewController
        if (table.address != nil) {
        prev.address  = table.address!
        prev.lat = table.lat!
        prev.long  = table.long!
            print (" \(table.address!) ")
        }
        
        
        
        
        
        
        self.navigationController?.popViewController(animated: true)
    }

    
    //MARK: Location manager delegate methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05,0.05)
            let region = MKCoordinateRegion(center: location.coordinate,span: span)
            mapView!.setRegion(region,animated: false)
           
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
   
    
  

}

class MySearchBar: UISearchBar {
    override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
      
    }
    override var showsCancelButton: Bool {
        get {
            return false
        }
        set {
            
        }
    }

    
   
}

class MySearchController: UISearchController {
    var myBar: UISearchBar? = MySearchBar()
    
    override var searchBar: UISearchBar {
        get {
            return myBar!
        }
        
   
    }
}

