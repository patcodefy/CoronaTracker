//
//  ViewController.swift
//  CoronaTracker
//
//  Created by pat on 3/23/20.
//  Copyright © 2020 pat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    
   
    

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerUIStackView: UIStackView!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var countrySelectorView: UIStackView!
    @IBOutlet weak var statsCollectionView: UICollectionView!
    
    var countryList: [String] = []
    var date = ""
    let reuseIdentifier = "statsCell"
    var items = ["title 1", "title 2","title 1", "title 2","title 1", "title 2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        statsCollectionView.delegate = self
        statsCollectionView.dataSource = self
        for countryCode in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: countryCode])
            countryList.append(NSLocale.init(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country Not Found")
        }
    }
    //Actions
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
    @IBAction func doneDatePickerBtn(_ sender: UIButton) {
        datePickerUIStackView.isHidden = true
        datePicker.backgroundColor = .clear
    }
    
    @IBAction func showCountryPickerBtn(_ sender: UIButton) {
        if datePickerUIStackView.isHidden {
            countrySelectorView.isHidden = false
        } else {
            datePickerUIStackView.isHidden = true
            countrySelectorView.isHidden = false
        }
        
        
    }
    @IBAction func showDatePicker(_ sender: UIButton) {
        if countrySelectorView.isHidden {
            datePickerUIStackView.isHidden = false
            datePicker.backgroundColor = .red
        } else {
            countrySelectorView.isHidden = true
            datePickerUIStackView.isHidden = false
        }
        
    }
    
    @IBAction func doneCountryPickerBtn(_ sender: UIButton) {
        countrySelectorView.isHidden = true
    }
    
    //Country Picker Protocols
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
    
    //Stats CollectionView protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! StatsCollectionViewCell
        cell.titleUILabel.text = items[indexPath.item]
        return cell
    }
}

