//
//  ViewController.swift
//  201312356
//
//  Created by D7703_30 on 2017. 9. 18..
//  Copyright © 2017년 D7703_30. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController,MKMapViewDelegate{

    @IBOutlet weak var myMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locateToCenter()
        // plist data 가져오기
        let path = Bundle.main.path(forResource: "ViewPoint", ofType: "plist")
        print("path=\(String(describing: path))")
        
        let contents = NSArray(contentsOfFile: path!)
        print("contents=\(String(describing: contents))")
        // pin point를 저장하기 위한 배열 선언
        var annotations = [MKPointAnnotation]()
        // content(딕셔너리의 배열)에서 데이터 뽑아오기
        if let myItems = contents
        {
            for item in myItems
            {
            let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subTitle = (item as AnyObject).value(forKey: "subTitle")
            
            print("lat = \(String(describing: lat))")
                
            let annotation = MKPointAnnotation()
            
            let myLat = (lat as! NSString).doubleValue
            let myLong = (long as! NSString).doubleValue
            let myTitle = title as? String
            let mySubTitle = subTitle as? String
                annotation.coordinate.latitude = myLat
                annotation.coordinate.longitude = myLong
                annotation.title = myTitle
                annotation.subtitle = mySubTitle
                annotations.append(annotation)
                
                myMapView.delegate = self
            }
        }else{print("aaa")}
        myMapView.showAnnotations(annotations, animated: true)
        myMapView.addAnnotations(annotations)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locateToCenter(){
    let center = CLLocationCoordinate2DMake(35.166197, 129.072594)
    let span = MKCoordinateSpanMake(0.05, 0.05)
    let region = MKCoordinateRegionMake(center, span)
        myMapView.setRegion(region, animated: true)
    }

}
