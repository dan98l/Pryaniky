//
//  ViewController.swift
//  Pryanky
//
//  Created by Daniil G on 14.10.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

class View: UIViewController, AlertPickerView {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var presenter = Presenter()
    private var pryanikyData = [String: Info]()
    private var pryanikyView:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.start() { data, view in
            self.pryanikyData = data
            self.pryanikyView = view
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func alert(message: String) {
        let alert = UIAlertController(title: "About", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension UITableView
extension View: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        cell.delegate = self as AlertPickerView
        
        let name = self.pryanikyData[self.pryanikyView[indexPath.row]]?.text
        let url = self.pryanikyData[self.pryanikyView[indexPath.row]]?.url
        let variants = self.pryanikyData[self.pryanikyView[indexPath.row]]?.variants
        
        if name != nil {
            cell.cellLabel.isHidden = false
            cell.cellLabel.text = name
        }
        
        if url != nil {
            cell.cellImage.isHidden = false
            cell.cellImage.load(url: URL(string: url!)!)
        }
        
        if variants != nil {
            cell.cellPicker.isHidden = false
            cell.pickerCountComponent = variants!.count
            cell.selectorText = getArrays(variants: variants!).text
            cell.selectorId = getArrays(variants: variants!).id
        }
        
        return cell
    }
    
    func getArrays(variants: [Variant]) -> (id: [Int], text: [String]) {
        var selectorText = [String]()
        var selectorId = [Int]()
        for i in variants {
            selectorText.append(i.text)
            selectorId.append(i.id)
        }
        return (id: selectorId, text: selectorText)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       alert(message: "Name \(pryanikyView[indexPath.row])")
       DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
