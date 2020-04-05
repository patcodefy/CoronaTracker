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
    @IBOutlet weak var dateUILabel: UILabel!
    var date = ""
    var country : String = ""
    let reuseIdentifier = "statsCell"
    var countryData: Countrydata?
    var countryCodes = CountryList.init().codes
    var countryList: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Date()
        dateUILabel.text = currentDate(date: Date())
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        statsCollectionView.delegate = self
        statsCollectionView.dataSource = self
        for countryCode in countryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: countryCode])
            print (id)
            countryList.append(NSLocale.init(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country Not Found")
        }
    }
   
    //Actions
    @IBAction func selectDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        date = dateFormatter.string(from: datePicker.date)
        print (date)
    }
    @IBAction func doneDatePickerBtn(_ sender: UIButton) {
        datePickerUIStackView.isHidden = true
        datePicker.backgroundColor = .clear
        statsCollectionView.isHidden = false
    }
    
    @IBAction func showCountryPickerBtn(_ sender: UIButton) {
        if datePickerUIStackView.isHidden {
            countrySelectorView.isHidden = false
            statsCollectionView.isHidden = true
        } else {
            datePickerUIStackView.isHidden = true
            countrySelectorView.isHidden = false
        }
        
        
    }
    @IBAction func showDatePicker(_ sender: UIButton) {
        if countrySelectorView.isHidden {
            datePickerUIStackView.isHidden = false
            datePicker.backgroundColor = .red
            statsCollectionView.isHidden = true
        } else {
            countrySelectorView.isHidden = true
            datePickerUIStackView.isHidden = false
        }
        
    }
    
    @IBAction func doneCountryPickerBtn(_ sender: UIButton) {
        loadData()
        countrySelectorView.isHidden = true
        statsCollectionView.isHidden = false
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
        self.country = countryCodes[row]
        //print (self.country)
    }
    
    //Stats CollectionView protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryData?.data.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! StatsCollectionViewCell
        cell.cellData = countryData?.data[indexPath.item]
        return cell
    }
    
    
    //Request country data
    private func getData(completionHandler: @escaping(Response) ->Void)  {
        let decoder = JSONDecoder()
        let url = URL(string: "https://thevirustracker.com/free-api?countryTotal=\(self.country)")!
        print (url)
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                print ("data = nil")
                return
            }
            guard let results = try? decoder.decode(Response.self, from: data) else {
                print ("results = nil")
                return
                
            }
            DispatchQueue.main.async {
                completionHandler(results)
            }
            
        }
        task.resume()
    }
//    private func countryNameCode(for fullCountryName : String) -> String {
//        for localeCode in NSLocale.isoCountryCodes {
//            let identifier = NSLocale(localeIdentifier: localeCode)
//            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
//            if fullCountryName.lowercased() == countryName?.lowercased() {
//                return localeCode
//            }
//        }
//        return ""
//    }
    private func loadData(){
        getData{ (results) in
            self.countryData = results.countrydata.first
            self.statsCollectionView.reloadData()
        }
        
    }
    
    private func currentDate(date: Date, style: String = "medium") -> String {
        let dateFormatter = DateFormatter()
        if style == "short" {
            dateFormatter.dateStyle = .short
        } else {
            dateFormatter.dateStyle = .medium
        }
        return dateFormatter.string(from: Date())
    }
    
    
}

