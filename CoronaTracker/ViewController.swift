//
//  ViewController.swift
//  CoronaTracker
//
//  Created by pat on 3/23/20.
//  Copyright © 2020 pat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func getData(_ sender: UIButton) {
        print ("button clicked")
        let url = URL(string: "https://thevirustracker.com/free-api?countryTotal=RW")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {return}
            guard let countryData = json["countrydata"] else {return}
            //print(String(data: data, encoding: .utf8)!)
            print (countryData)
           
        }

        task.resume()
    }
    
    @IBAction func showDatePicker(_ sender: UIButton) {
        datePicker.isHidden = false
        datePicker.backgroundColor = .red
    }
    
}

