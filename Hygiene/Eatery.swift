//
//  Eatery.swift
//  Hygiene
//
//  Created by Edith Dande on 06/04/2018.
//

import Foundation

struct Eatery: Codable {
    var id: String?
    var BusinessName: String?
    var AddressLine1: String?
    var AddressLine2: String?
    var AddressLine3: String?
    var RatingValue: String?
    var RatingDate: String?
    var Longitude: String?
    var Latitude: String?
    var DistanceKM: String?
    
    static func endpointForLocation(_ longitude: Double, _ latitude: Double) -> String {
        return "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(latitude)&long=\(longitude)"
    }
    
    static func endpointForName(_ name: String) -> String {
        return "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_name&name=\(name)"
    }
    
    static func endpointForPost(_ postCode: String) -> String {
        return "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_postcode&postcode=\(postCode)"
    }
    static func nearest(_ latitude: Double, _ longitude: Double, completionHandler: @escaping ([Eatery]?, Error?) -> Void) {
        let endpoint = Eatery.endpointForLocation(latitude, longitude)
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let eateries = try decoder.decode([Eatery].self, from: responseData)
                completionHandler(eateries, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    static func postCode(_ postCode: String, completionHandler: @escaping ([Eatery]?, Error?) -> Void) {
        let endpoint = Eatery.endpointForPost(postCode)
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let eateries = try decoder.decode([Eatery].self, from: responseData)
                completionHandler(eateries, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }

    static func name(_ name: String, completionHandler: @escaping ([Eatery]?, Error?) -> Void) {
        let newName = name.replacingOccurrences(of: " ", with: "%20")
        let endpoint = Eatery.endpointForName(newName)
        print(endpoint)
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let eateries = try decoder.decode([Eatery].self, from: responseData)
                completionHandler(eateries, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}
