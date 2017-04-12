//
//  LoginModel.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import Foundation

/// Model class for verifying username / password combinations. You do not need to edit this file
class LoginModel {
    
    // Key: berkeley.edu account names. Value: Passwords (student's first name)
    var userDictionary = [String: String]()
    
    // The name of the file with usernames and passwords
    var csvFileName: String
    
    /// Designated initializer for `LoginModel`
    ///
    /// - Parameter filename: The name of the csv file with usernames and passwords
    init(filename: String) {
        csvFileName = filename
        populateDictionaryWithNamesFromCSV()
    }
    
    /// Fills the `userDictionary` with student e-mails and passwords
    func populateDictionaryWithNamesFromCSV() {
        guard let csvPath = Bundle.main.path(forResource: csvFileName, ofType: "csv") else { return }
        do {
            let csvData = try String(contentsOfFile: csvPath, encoding: String.Encoding.utf8)
            for row in csvData.csvRows() {
                // berkeley.edu account (i.e. oskibear@berkeley.edu)
                let username: String = row[0]
                // First name (i.e. Oski)
                let password: String = row[1]
                userDictionary[username] = password
            }
        } catch {
            print(error)
        }
    }
    
    /// Returns whether or not username:password is a valid combination
    ///
    /// - Parameters:
    ///   - username: The berkeley.edu account string
    ///   - password: The student's first name (password)
    /// - Returns: true if their exists a user with the given username and password
    func authenticate(username: String?, password: String?) -> Bool {
        if let username = username, let password = password {
            return userDictionary[username] == password
        }
        return false
    }
}
