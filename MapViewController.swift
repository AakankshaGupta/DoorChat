//
//  MapViewController.swift
//  DoorChat
//
//  Created by Aseem14 on 04/03/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate
{
    var mylat: String?
    var mylng : String?
    var token : String?
    
    var currentLocation : CLLocation?
    var db = DBManager()
    var tapGesture : UITapGestureRecognizer?
    var LAT: String?
    var LONG: String?
    
    var array1 : [User]?
    
    @IBOutlet weak var map_height_constraint: NSLayoutConstraint!
    @IBOutlet weak var people_count: UILabel!
    @IBOutlet weak var map_pressed_view: UIView!
    @IBOutlet weak var door_distance: UILabel!
    @IBOutlet weak var door_tym: UILabel!
    @IBOutlet weak var door_title: UILabel!
    @IBOutlet weak var people_view: UIView!
    @IBOutlet weak var chat_btn: UIButton!
    
    @IBOutlet weak var mymap: MKMapView!{
        didSet {
            mymap.delegate = self
            mymap.mapType = .Standard
            mymap.pitchEnabled = false
            mymap.rotateEnabled = false
            mymap.scrollEnabled = true
            mymap.zoomEnabled = true
        }
    }
    
    let regionRadius: CLLocationDistance = 2000
    var locationManager = CLLocationManager()
    var lat_arr : [String]?
    var lng_arr : [String]?
    var door_label: UILabel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        map_pressed_view.hidden = true
        self.locationset()
        self.mydoorslocation()
        mymap.delegate = self
        
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        
        people_view.layer.borderWidth=1.0
        people_view.layer.masksToBounds = false
        people_view.layer.cornerRadius = 10
        people_view.layer.borderColor = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1.0).CGColor
        people_view.clipsToBounds = true
        chat_btn.layer.borderWidth=2.0
        chat_btn.layer.masksToBounds = false
        chat_btn.layer.borderColor = UIColor(red:81/255.0, green:180/255.0, blue:245/255.0, alpha: 1.0).CGColor
        chat_btn.layer.cornerRadius = 5
        chat_btn.clipsToBounds = true


    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func chat_btn(sender: AnyObject) {
    }

    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
       
        mymap.setRegion(coordinateRegion, animated: true)
    }
   
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation)
    {
        
         self.currentLocation = newLocation
        self.mylat = "\(currentLocation!.coordinate.latitude)"
        self.mylng = "\(currentLocation!.coordinate.longitude)"
        self.centerMapOnLocation(currentLocation!)
    }
    
      func locationset()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
     }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("error to get location : \(error)")
    }
    
   

    func mydoorslocation()
    {
          for counter in array1!
        {
            
            guard let lat = counter.door_lat, lng = counter.door_lng  else{return}
            
            currentLocation = CLLocation(latitude: (lat as NSString).doubleValue , longitude: (lng as NSString).doubleValue)
            let center = CLLocationCoordinate2D(latitude: (lat as NSString).doubleValue , longitude:  (lng as NSString) .doubleValue)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = center
            
            mymap.centerCoordinate = CLLocationCoordinate2DMake(currentLocation!.coordinate.latitude, currentLocation!.coordinate.longitude)
            
            LAT = "latitude: \(locationManager.location!.coordinate.latitude)"
            LONG = "longitude: \(locationManager.location!.coordinate.longitude)"
            
            self.mymap.addAnnotation(annotation)
            self.mymap.setRegion(region, animated: true)
         }
    }
   
    func getdata(lat: String!, lng: String!)
    {
        for counter in array1!
        {
           if(counter.door_lat == lat && counter.door_lng == String(lng))
        {
            
            self.door_title.text = counter.door_title
            self.door_tym.text = counter.door_tym
            self.people_count.text = counter.door_total_member
        }
     }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
      
        tapGesture = UITapGestureRecognizer(target: self, action: Selector("recognizeTapGesture:"))
        view.addGestureRecognizer(tapGesture!)

        if !(annotation is MKPointAnnotation)
        {
            return nil
        }
        
        let reuseId = "test"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)

        if anView == nil
        {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = false
        }
        else
        {
        anView!.annotation = annotation
        }
        
        let custom = CustomPointAnnotation()
        anView!.image = UIImage(named:"ic_pin_map")

        let label_lat = annotation.coordinate.latitude
        let label_lng = annotation.coordinate.longitude
        custom.array1 = self.array1
        custom.addLabel("\(label_lat)", lng: "\(label_lng)")
        custom.label.frame = anView!.frame
        custom.label.frame.size.width = 100
        custom.label.textAlignment = NSTextAlignment.Right
        custom.label.clipsToBounds = true
        custom.label.frame = CGRectMake(custom.label.frame.origin.x-custom.label.frame.size.width/1.25, custom.label.frame.origin.y+custom.label.frame.size.height/2, custom.label.frame.size.width, custom.label.frame.size.height)
        custom.label.numberOfLines = 1
        custom.label.font = UIFont.boldSystemFontOfSize(10)
        custom.label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        anView!.addSubview(custom.label)
        
        return anView
    }
    

    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
    {
        self.map_pressed_view.hidden = false
        guard  let annotationPressed = view.annotation?.coordinate else{return}
        self.getdata("\(annotationPressed.latitude)", lng:"\(annotationPressed.longitude)")
       
        UIView.animateWithDuration(1.0, animations: {
                            self.map_height_constraint.constant = 100.0
                            self.view.layoutIfNeeded()
        })
    }
    
    func recognizeTapGesture(recognizer: UITapGestureRecognizer)
    {
        UIView.animateWithDuration(0.5, animations:
        {
                self.map_height_constraint.constant = 0.0
                self.view.layoutIfNeeded()
        })
       view.removeGestureRecognizer(tapGesture!)
    }
    
   }


