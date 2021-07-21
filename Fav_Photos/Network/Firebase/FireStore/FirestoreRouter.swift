//
//  Router.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//
import Foundation

protocol FireBaseRouter {
    associatedtype Endpoint: FirestoreRequest
    func request(_ request: Endpoint, completion: @escaping NetworkRouterCompletion)
}

