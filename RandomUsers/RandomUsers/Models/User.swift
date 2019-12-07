//
//  User.swift
//  RandomUsers
//
//  Created by Percy Ngan on 12/6/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

struct UserResult: Decodable {
	let results: [User] // This is an array of users

}

struct User: Decodable {
	let name: String
	let email: String

}
