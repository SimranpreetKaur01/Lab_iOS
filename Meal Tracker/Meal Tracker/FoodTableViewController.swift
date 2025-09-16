//
//  FoodTableViewController.swift
//  Meal Tracker
//
//  Created by Simran on 18/08/25.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    var meals: [Meal] {
            
            let pancakes = Food(name: "Pancakes", description: "Fluffy pancakes with syrup")
            let eggs = Food(name: "Scrambled Eggs", description: "Light and fluffy scrambled eggs")
            let coffee = Food(name: "Coffee", description: "Freshly brewed hot coffee")
            let breakfast = Meal(name: "Breakfast", food: [pancakes, eggs, coffee])
            
            let sandwich = Food(name: "Sandwich", description: "Ham and cheese sandwich")
            let salad = Food(name: "Salad", description: "Fresh garden salad with dressing")
            let juice = Food(name: "Orange Juice", description: "Chilled orange juice")
            let lunch = Meal(name: "Lunch", food: [sandwich, salad, juice])
            
            let pasta = Food(name: "Pasta", description: "Spaghetti with marinara sauce")
            let steak = Food(name: "Steak", description: "Grilled sirloin steak")
            let wine = Food(name: "Red Wine", description: "Glass of cabernet sauvignon")
            let dinner = Meal(name: "Dinner", food: [pasta, steak, wine])
            
            return [breakfast, lunch, dinner]
        }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let meal = meals[section]
        return meal.food.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)
                
        let meal = meals[indexPath.section]
        let foodItem = meal.food[indexPath.row]
                
        var content = cell.defaultContentConfiguration()
        content.text = foodItem.name
        content.secondaryText = foodItem.description
        cell.contentConfiguration = content
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
