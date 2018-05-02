//
//  ViewController.swift
//  ExampleBsuirProject
//
//  Created by Andrew Rolya on 3/6/18.
//  Copyright © 2018 Andrew Rolya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let sheduleService = SheduleService()
    
    @IBAction func getGroups(_sender: Any) {
        print("get groups tapped")
    }
    
    @IBAction func getSheduleTapped(_ sender: Any) {
        sheduleService.requestSheduleGroup(groupName: "451005") { (result, error) -> (Void) in
            if let result = result {
                print(result)
            } else {
                print(error)
            }
        }
    }
}

