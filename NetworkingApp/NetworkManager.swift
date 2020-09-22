//
//  NetworkManager.swift
//  NetworkingApp
//
//  Created by Aleksandr on 21.09.2020.
//

import Foundation

class NetworkManager {
  
  static let instance = NetworkManager()
  
  private init() {}
  
  func fetchData<T: Decodable>(jsonUrl: String, type: T.Type,
                               complitionHandler: @escaping (T) -> Void ) {
    guard let url = URL(string: jsonUrl) else { return }
    
    URLSession.shared.dataTask(with: url) { (response, _, error) in
      if let error = error {
        print(error)
        return
      }
      guard let response = response else { return }
      do {
        let model = try JSONDecoder().decode(type, from: response)
        complitionHandler(model)
      } catch let error {
        print(error.localizedDescription)
      }
    }.resume()
  }
}
