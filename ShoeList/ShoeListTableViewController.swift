//
//  ShoeListTableViewController.swift
//  ShoeList
//
//  Created by Frank on 12/15/18.
//  Copyright © 2018 Analog Potato. All rights reserved.
//

import UIKit

class ShoeListTableViewController: UITableViewController {

    var ShoeListItems : [ShoeListCoreData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getShoeList()
    }
    
    func getShoeList() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataShoeList = try? context.fetch(ShoeListCoreData.fetchRequest()) as? [ShoeListCoreData] {
                if let arrayShoeList = coreDataShoeList {
                    ShoeListItems = arrayShoeList
                    tableView.reloadData()
                    
                }
            }
        }
    }
    
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ShoeListItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoeListIdentifier", for: indexPath)

        let shoeList = ShoeListItems[indexPath.row]
        
        if let name = shoeList.name {
        if shoeList.favorite {
            cell.textLabel?.text = "⭐️ " + name
        } else {
            cell.textLabel?.text = shoeList.name
        }
    }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shoeList = ShoeListItems[indexPath.row]
        performSegue(withIdentifier: "moveToShoeVC", sender: shoeList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addShoeVC = segue.destination as? AddShoeViewController {
        addShoeVC.shoeVC = self
    }
        if let shoeDataVC = segue.destination as? ShoeDataViewController {
            
            if let ShoeList = sender as? ShoeListCoreData {
            shoeDataVC.selectedShoeList = ShoeList
                shoeDataVC.shoeVC = self
            }
        }
    }


}
