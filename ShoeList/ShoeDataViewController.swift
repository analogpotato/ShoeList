//
//  ShoeDataViewController.swift
//  ShoeList
//
//  Created by Frank on 12/15/18.
//  Copyright © 2018 Analog Potato. All rights reserved.
//

import UIKit

class ShoeDataViewController: UIViewController {

    var shoeVC = ShoeListTableViewController()
    var selectedShoeList : ShoeListCoreData? = nil
    //Variables
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var totalMilesLabel: UILabel!
    @IBOutlet weak var removeMilesLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoeNameLabel.text = selectedShoeList?.name
        totalMilesLabel.text = selectedShoeList?.totalMiles
        // Do any additional setup after loading the view.
    }
    
    var addMiles: Double? {
        guard let addMilesValue = removeMilesLabel.text else {
            return nil
        }
        return Double (addMilesValue)
    }
    
    var totalMiles: Double? {
        guard let addMilesValue = totalMilesLabel.text else {
            return nil
        }
        return Double (addMilesValue)
    }
    
    
    
    @IBAction func addMilesButton(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let addData = selectedShoeList
            if let addMilesData = addData {
                totalMilesLabel.text = addMilesData.totalMiles
        }
        try? context.save()
    }
        
      if totalMilesLabel != nil {
            let finalOutput = Double ((totalMiles)! - (addMiles)!)
            totalMilesLabel.text = "\(finalOutput)"
        }
        
    }
        
    @IBAction func deleteShoeButton(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let theShoeList = selectedShoeList {
                context.delete(theShoeList)
                try? context.save()
                navigationController?.popViewController(animated: true)
            }

        }



/* var shoeIndex = 0
        for shoe in shoeVC.ShoeListItems {
            if shoe.name == selectedShoeList.name {
                shoeVC.ShoeListItems.remove(at: shoeIndex)
                shoeVC.tableView.reloadData()
                navigationController?.popViewController(animated: true)
                break
            }
            shoeIndex += 1
            
        }
    }*/
    }

}
