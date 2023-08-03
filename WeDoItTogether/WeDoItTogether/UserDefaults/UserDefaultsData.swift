//
//  UserDefaultsData.swift
//  WeDoItTogether
//
//  Created by 최하늘 on 2023/08/03.
//

import Foundation

class UserDefaultsData {
    enum Key: String, CaseIterable {
        case latitude, longitude
        case email, name, password
    }
    
    static let shared: UserDefaultsData = {
        return UserDefaultsData()
    }()
    
    func removeAll() {
        Key.allCases.forEach {
            UserDefaults.standard.removeObject(forKey: $0.rawValue)
        }
    }
    
    func setLocation(latitude: Double, longitude: Double) {
        UserDefaults.standard.setValue(latitude, forKey: Key.latitude.rawValue)
        UserDefaults.standard.setValue(longitude, forKey: Key.longitude.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getLocation() -> CurrentLocation {
        let latitude = UserDefaults.standard.double(forKey: Key.latitude.rawValue)
        let longitude = UserDefaults.standard.double(forKey: Key.longitude.rawValue)
        return CurrentLocation(latitude: latitude, longitude: longitude)
    }
    
    func setUser(email: String, name: String, password: String) {
        UserDefaults.standard.setValue(email, forKey: Key.email.rawValue)
        UserDefaults.standard.setValue(name, forKey: Key.name.rawValue)
        UserDefaults.standard.setValue(password, forKey: Key.password.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getUser() -> User? {
        guard let email = UserDefaults.standard.string(forKey: Key.email.rawValue) else {
            return nil
        }
        guard let name = UserDefaults.standard.string(forKey: Key.name.rawValue) else {
            return nil
        }
        guard let password = UserDefaults.standard.string(forKey: Key.password.rawValue) else {
            return nil
        }
        
        return User(email: email, name: name, password: password)
    }
}
