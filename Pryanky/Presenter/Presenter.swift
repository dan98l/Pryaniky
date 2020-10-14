//
//  Presenter.swift
//  Pryanky
//
//  Created by Daniil G on 14.10.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

final class Presenter {
    
    private var pryaniky:[String: Info] = [:]
    private var view:[String] = []
    
    private var cell:[Info] = []
    
    func start(completion: @escaping (Dictionary<String, Info>, [String]) -> () ) {
        APIService.getWeatherData(urlString: "https://pryaniky.com/static/json/sample.json") { [weak self] result in
             switch result {
                case .success(let pryanikyList):
                    for i in [pryanikyList][0].data {
                        self!.pryaniky[i.name] = i.data
                    }
                    self!.view = [pryanikyList][0].view
                    completion(self!.pryaniky, self!.view)
                case .failure(let error):
                    print("Error json: \(error)")
            }
        }
    }
    
    
    func getCount() -> Int {
        return view.count
    }
}
