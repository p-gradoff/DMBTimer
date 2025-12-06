//
//  AuthErrors.swift
//  DMBTimer
//
//  Created by Павел Градов on 06.12.2025.
//

import Foundation

enum AuthErrors: Error, LocalizedError {
    case userAlreadyExists
    case userSavingError
    case decodingError
    case usersNotFound
    case userNotFound
    case savingError
    
    var failureReason: String {
        switch self {
        case .userAlreadyExists: "Пользователь с таким именем уже существует."
        case .userSavingError: "Ошибка сохранения пользователя."
        case .decodingError: fallthrough
        case .usersNotFound: "Не удалось загрузить профили."
        case .userNotFound: "Не удалось найти профиль."
        case .savingError: "Не удалось сохранить изменения."
        }
    }
    
    var errorDescription: String {
        switch self {
        case .userAlreadyExists: "Введите другое имя пользователя."
        case .userSavingError: "Попробуйте позже."
        case .decodingError: fallthrough
        case .usersNotFound: "Перезагрузите приложение."
        case .userNotFound: "Перезагрузите приложение."
        case .savingError: "Попробуйте ещё раз." 
        }
    }
}
