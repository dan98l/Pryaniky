//
//  ExtensionUIImageView .swift
//  Pryanky
//
//  Created by Daniil G on 15.10.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
