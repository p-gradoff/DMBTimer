//
//  AuthService.swift
//  DMBTimer
//
//  Created by Павел Градов on 06.12.2025.
//

import Foundation

protocol UsersListManaging {
    func getUsersList() throws -> [User]
    func createUser(_ user: User) throws
    func deleteUser(by id: String) throws
}

protocol CurrentUserManaging {
    func getUser(by id: String) throws -> User
    func logout()
}

class AuthService {
    private enum Keys {
        static let users = "authorizedUsers"
        static let currentUserID = "currentUserID"
    }
    
    private let defaults = UserDefaults.standard
    
    var currentUserID: String? {
        get {
            defaults.string(forKey: Keys.currentUserID)
        } set(id) {
            defaults.set(id, forKey: Keys.currentUserID)
        }
    }
}

extension AuthService: UsersListManaging {
    func getUsersList() throws -> [User] {
        guard let data = defaults.data(forKey: Keys.users) else {
            throw AuthErrors.usersNotFound
        }
        
        do {
            return try JSONDecoder().decode([User].self, from: data)
        } catch {
            throw AuthErrors.decodingError
        }
    }
    
    func createUser(_ user: User) throws {
        var users = try getUsersList()
        
        guard !users.contains(where: { $0.id == user.id }) else {
            throw AuthErrors.userAlreadyExists
        }
        
        users.append(user)
        currentUserID = user.id
        
        do {
            let encodedUser = try JSONEncoder().encode(users)
            defaults.set(encodedUser, forKey: Keys.users)
        } catch {
            throw AuthErrors.userSavingError
        }
    }
    
    func deleteUser(by id: String) throws {
        var users = try getUsersList()
        users.removeAll(where: { $0.id == id })
        
        do {
            let encodedUsers = try JSONEncoder().encode(users)
            defaults.set(encodedUsers, forKey: Keys.users)
        } catch {
            throw AuthErrors.userSavingError
        }
    }
}

extension AuthService: CurrentUserManaging {
    func getUser(by id: String) throws -> User {
        let users = try getUsersList()
        
        guard let user = users.first(where: { $0.id == id }) else {
            throw AuthErrors.userNotFound
        }
        
        return user
    }
    
    func logout() {
        defaults.removeObject(forKey: Keys.currentUserID)
    }
}
