//
//  UserModel.swift
//  DMBTimer
//
//  Created by Павел Градов on 06.12.2025.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let userName: String
    let startDate: Date
    let endDate: Date
}
