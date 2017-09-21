//
//  ViewController.swift
//  201312356
//
//  Created by D7703_30 on 2017. 9. 18..
//  Copyright © 2017년 D7703_30. All rights reserved.
//

import UIKit
import MapKit
var picarray = [String]()
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
                let imgs = (item as AnyObject).value(forKey: "pic")
                
            print("lat = \(String(describing: lat))")
                
            let annotation = MKPointAnnotation()
            
            let myLat = (lat as! NSString).doubleValue
            let myLong = (long as! NSString).doubleValue
            let myTitle = title as? String
            let mySubTitle = subTitle as? String
            let myPic = imgs as! String
                picarray.append(myPic)
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myPin"
        
        // an already allocated annotation view
        var annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            //annotationView?.pinTintColor = UIColor.green
            annotationView?.animatesDrop = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        if annotation.title! == "Dit 동의과학대학교" {
            leftIconView.image = UIImage(named:picarray[0] )
            annotationView?.pinTintColor = UIColor.green
        }
        if annotation.title! == "시민공원" {
            leftIconView.image = UIImage(named:picarray[1] )
            annotationView?.pinTintColor = UIColor.blue
        }
        if annotation.title! == "송상현광장" {
            leftIconView.image = UIImage(named:picarray[2] )
            annotationView?.pinTintColor = UIColor.black
        }
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
        
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let viewAnno = view.annotation //as! ViewPoint
        let placeName = viewAnno?.title
        let placeInfo = viewAnno?.subtitle
        
        let ac = UIAlertController(title: placeName!, message: placeInfo!, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }

}
