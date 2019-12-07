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
	var name: Name
	var email: String
	var phone: String
}

struct Name: Decodable {
	let first: String
	let last: String
	// Nested data is value that is nested inside another value
	
}
