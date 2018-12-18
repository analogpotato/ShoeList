//
//  AddShoeViewController.swift
//  ShoeList
//
//  Created by Frank on 12/15/18.
//  Copyright © 2018 Analog Potato. All rights reserved.
//

import UIKit

class AddShoeViewController: UIViewController {
    
    var shoeVC = ShoeListTableViewController()

    @IBOutlet weak var shoeNameTextField: UITextField!
    @IBOutlet weak var startingMilesTextField: UITextField!
    @IBOutlet weak var totalMilesTextField: UITextField!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addShoeButton(_ sender: Any) {
        /*
        let addShoe = ShoeList()
        addShoe.name = shoeNameTextField.text!
        addShoe.addMiles = startingMilesTextField.text!
        addShoe.totalMiles = totalMilesTextField.text!
        addShoe.favorite = favoriteSwitch.isOn
        
        shoeVC.ShoeListItems.append(addShoe)
        shoeVC.tableView.reloadData()
        navigationController?.popViewController(animated: true)*/
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let addShoe = ShoeListCoreData(entity: ShoeListCoreData.entity(), insertInto: context)
            
            if let shoeNameText = shoeNameTextField.text {
                addShoe.name = shoeNameText
                addShoe.totalMiles = totalMilesTextField.text!
                addShoe.favorite = favoriteSwitch.isOn
                
            }
            
            try? context.save()
            
            
            
        }
        navigationController?.popViewController(animated: true)
    }
    

}
