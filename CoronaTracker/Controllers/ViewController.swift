//
//  ViewController.swift
//  CoronaTracker
//
//  Created by pat on 3/23/20.
//  Copyright © 2020 pat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var statsSourceUILabel: UILabel!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var countrySelectorView: UIStackView!
    @IBOutlet weak var statsCollectionView: UICollectionView!
    @IBOutlet weak var dateUILabel: UILabel!
    
    private var countryCode : String = ""
    private let reuseIdentifier = "statsCell"
    private var getGlobal = true
    private var countryData: Countrydata?
    private var globalData: GlobalResults?
    private var countryCodes = CountryList.init().codes
    private var countryList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateUILabel.text = currentDate(date: Date()).uppercased()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        statsCollectionView.delegate = self
        statsCollectionView.dataSource = self
        for code in countryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            countryList.append(NSLocale.init(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country Not Found")
        }
        loadData(isGlobal: getGlobal)
    }
   
    //Actions
    @IBAction func showCountryPickerBtn(_ sender: UIButton) {
        statsCollectionView.isHidden = true
        countrySelectorView.isHidden = false
    }

    @IBAction func doneCountryPickerBtn(_ sender: UIButton) {
        getGlobal = false
        loadData(isGlobal: getGlobal)
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
        self.countryCode = countryCodes[row]
        statsSourceUILabel.text = "\(countryList[row])".uppercased()
    }
    
    //Stats CollectionView protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if getGlobal {
            return globalData?.data.count ?? 0
        } else {
            return countryData?.data.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! StatsCollectionViewCell
        if getGlobal {
            cell.cellData = globalData?.data[indexPath.item]
        } else {
            cell.cellData = countryData?.data[indexPath.item]
        }
        return cell
    }
    
    private func loadData(isGlobal: Bool){
        let request = NetworkRequest (
            countryCode: self.countryCode
        )
        if isGlobal || self.countryCode == "" {
            request.getGlobalData{(results) in
            self.globalData = results
                self.statsCollectionView.reloadData()
            }
        } else {
            request.getCountryData{ (results) in
                self.countryData = results
                self.statsCollectionView.reloadData()
            }
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

