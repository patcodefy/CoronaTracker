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
    var statsData:[Int] = []
    var titles = [
        "total cases",
        "total recovered",
        "total unresolved",
        "total deaths",
        "new cases today",
        "new deaths today",
        "total active cases",
        "serious cases",
        "danger rank",
    ]
    var country : String = "RW"
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
    @IBAction func selectDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        date = dateFormatter.string(from: datePicker.date)
        print (date)
    }
    @IBAction func doneDatePickerBtn(_ sender: UIButton) {
        datePickerUIStackView.isHidden = true
        datePicker.backgroundColor = .clear
        statsCollectionView.reloadData()
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
        countrySelectorView.isHidden = true
        statsCollectionView.reloadData()
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
        
        self.country = countryNameCode(for: countryList[row])
        print (self.country)
        print (countryList[row])
    }
    
    //Stats CollectionView protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! StatsCollectionViewCell
        getData(code: self.country){ (results) in
            self.assignData(results: results)
            DispatchQueue.main.async {
                cell.statsUILabel.text = String(self.statsData[indexPath.item])
            }
        }
        cell.titleUILabel.text = self.titles[indexPath.item].uppercased()
        return cell
    }
    
    
    //Request
    func getData(code: String, completionHandler: @escaping(Response) ->Void)  {
        let decoder = JSONDecoder()
        let url = URL(string: "https://thevirustracker.com/free-api?countryTotal=\(code)")!
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
            completionHandler(results)
        }
        task.resume()
    }
    
    func countryNameCode(for fullCountryName : String) -> String {
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode 
            }
        }
        return ""
    }
    func assignData(results: Response){
        self.statsData.append((results.countrydata.first!.total_cases))
        self.statsData.append((results.countrydata.first!.total_recovered))
        self.statsData.append((results.countrydata.first!.total_unresolved))
        self.statsData.append((results.countrydata.first!.total_deaths))
        self.statsData.append((results.countrydata.first!.total_new_cases_today))
        self.statsData.append((results.countrydata.first!.total_new_deaths_today))
        self.statsData.append((results.countrydata.first!.total_active_cases))
        self.statsData.append((results.countrydata.first!.total_serious_cases))
        self.statsData.append((results.countrydata.first!.total_danger_rank))
    }
    
}

