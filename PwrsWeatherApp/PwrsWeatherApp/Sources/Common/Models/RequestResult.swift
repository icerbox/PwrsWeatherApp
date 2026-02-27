//
//  RequestResult.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

enum RequestResult<T> {
    case success(T)
    case failure(String)
}
