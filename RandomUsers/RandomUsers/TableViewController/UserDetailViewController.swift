//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Percy Ngan on 12/6/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	var user: User? { // didSet will confirm that the value was passed to the detailVC
		didSet {
			updateViews()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		updateViews() // If you see a nil whenever you try to pass something in a segue, must updateViews and guard isViewLoaded
	}

	func updateViews() {
		guard isViewLoaded,
			let user = user else { return }
		title = user.name.first.capitalized + " " + user.name.last.capitalized
		emailLabel.text = user.email
		phoneLabel.text = user.phone
		guard let imageData = try? Data(contentsOf: user.picture.large) else { fatalError() }
		imageView.image = UIImage(data: imageData)
	}

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/

}
