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
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
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

        
        cell.contentView.backgroundColor = .clear
        let whiteRoundedView = UIView (frame: CGRect(x: 10, y: 30, width: 300.0, height: 50.0)) //TODO: Adjust the GCRect and figure out the best way to classify it, what are x,y,width and height?
        whiteRoundedView.backgroundColor = .blue
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 3.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: 0, height: 0)
        whiteRoundedView.layer.shadowOpacity = 0.5
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        
        
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
