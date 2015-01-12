//
//  ViewController.swift
//  What's The Weather
//
//  Created by Óscar Calles Sáez on 12/1/15.
//  Copyright (c) 2015 Legua Soft Games. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var labelWeather: UILabel!

    @IBAction func buttonPressed(sender: AnyObject) {
        
        //self.view.endEditing(true)
        
        let phrase = "<span class=\"phrase\">"
        let phrase2 = "</span>"
        
        var urlString = "http://www.weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        
        var url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            let tempUrlContent: String = urlContent as String
            
            if tempUrlContent.rangeOfString(phrase) != nil {

                var contentArray = NSArray(array: urlContent!.componentsSeparatedByString(phrase))
                var newContentArray = NSArray(array:contentArray[1].componentsSeparatedByString(phrase2))
            
                dispatch_async(dispatch_get_main_queue()){
            
                    self.labelWeather.text = newContentArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                }
            
            } else {
            
                dispatch_async(dispatch_get_main_queue()){
            
                    self.labelWeather.text = "Couldn't find that city - please try again"
                }
            
            }
        }
        
        task.resume()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

