//
//  UsersTableViewController.swift
//  RandomUsers
//
//  Created by Percy Ngan on 12/6/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

	let apiController = APIController()// Whenever we need to call a function that is in another class, we can just create an instance of the class.

    override func viewDidLoad() {
        super.viewDidLoad()
		apiController.getUsers { (error) in
			if let error = error {
				NSLog("Error performing data task: \(error)")
			}
			DispatchQueue.main.async { // This just puts the data on the main queue
				self.tableView.reloadData()
			}
		}
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return apiController.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)

		let user = apiController.users[indexPath.row] // indexpath is the address and the row is the place in the tableview
		cell.textLabel?.text = user.name.first.capitalized + " " + user.name.last.capitalized
		guard let imageData = try? Data(contentsOf: user.picture.thumbnail) else { fatalError() } // We are unwrapping with fatalError because return will not work in this situation because I think it would stop, instead fatalError will us a error message.
		cell.imageView?.image = UIImage(data: imageData) // Every basic cell comes with a picture frame that can have a picture assigned to it.
        return cell
		// We will pass the info from the tableview to the detail view
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


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "UserDetail" {
			guard let userDetailVC = segue.destination as? UserDetailViewController else { return } // This is the destination address
			guard  let indexPath = tableView.indexPathForSelectedRow else { return } // This is where the value is at in the tableView
			let user = apiController.users[indexPath.row]
			userDetailVC.user = user
		}
    }

}
