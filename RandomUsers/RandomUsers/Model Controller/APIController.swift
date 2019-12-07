//
//  APIController.swift
//  RandomUsers
//
//  Created by Percy Ngan on 12/6/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class APIController {

	var users: [User] = []

	let baseURL = URL(string: "https://randomuser.me/api/?format=json@results=20")!
	typealias CompletionHandler = (Error?) -> Void

	// In checking to see if there is an error and if there is data before we do the do-try-catch to retrieve the data.
	func getUsers(completion: @escaping CompletionHandler = { _ in }) {
		URLSession.shared.dataTask(with: baseURL) { (data, _, error) in // This in is basically saying to look for the data and error in the following
			if let error = error { // Using if let and not guard let because we don't care if we don't get an error outside of this function. The error is only informational and isn't a value.
				NSLog("Error getting users: \(error)")
			}
			guard let data = data else {
				NSLog("No data returned from data task.")
				completion(nil)
				return // Always need a return if you use a else statement
			}
			do {
				let newUsers = try JSONDecoder().decode(UserResult.self, from: data) // We get the data and want it to be in the format of UserResult
				print(newUsers) // Use this to see what is returned in console
				self.users = newUsers.results
			} catch {
				NSLog("Error decoding users: \(error)")
				completion(error) // We are calling completion because if there is an error we want it to completed and get out of the function
			}
			completion(nil)
		}.resume() // Everytime we make a closure, networking method, with a data task we have to have .resume(), this is telling it to do the data task.
	}
}
