//
//  DetailCell.swift
//  Pryanky
//
//  Created by Daniil G on 14.10.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

protocol AlertPickerView: class {
    func alert(message: String)
}

final class DetailCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var cellPicker: UIPickerView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    // MARK: - Properties
    private var view = View()
    var pickerCountComponent = 0
    var selectorText: [String]?
    var selectorId: [Int] = []
    weak var delegate: AlertPickerView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellPicker.delegate = self
        cellPicker.dataSource = self
    }
}

// MARK: - Extension UIPickerView
extension DetailCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerCountComponent
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let selector = selectorText else { return nil}
        return selector[row] 
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.alert(message: "ID \(selectorId[row])")
    }
}
