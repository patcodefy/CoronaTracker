//
//  ViewController.swift
//  CoronaTracker
//
//  Created by pat on 3/23/20.
//  Copyright © 2020 pat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerUIStackView: UIStackView!
    @IBOutlet weak var countryPickerView: UIPickerView!
    var countryList: [String] = []
    var date = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        for countryCode in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: countryCode])
            countryList.append(NSLocale.init(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country Not Found")
        }
    }

    @IBAction func showCountryPickerBtn(_ sender: UIButton) {
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
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        date = dateFormatter.string(from: datePicker.date)
        print (date)
    }
    @IBAction func cancelDatePickerBtn(_ sender: UIButton) {
        datePickerUIStackView.isHidden = true
        datePicker.backgroundColor = .clear
    }
    @IBAction func doneDatePickerBtn(_ sender: UIButton) {
    }
    @IBAction func showDatePicker(_ sender: UIButton) {
        datePickerUIStackView.isHidden = false
        datePicker.backgroundColor = .red
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print (countryList[row])
    }
}

