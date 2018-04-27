//
//  MessageController.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/14/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import Foundation

class MessageController{
    var messages: [Message] = []
    var liked: [String] = []
    var disliked: [String] = []
    
    func getMessages(callBack: @escaping (_ : Error?) -> () ) {
        
        //self.messages = []
        let urlString = "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.messages.removeAll()
                    for result in results.messages {
                        if let message = result as? Message {  //I know this always succedes, but it wont work without it
                            self.messages.append(message)
                        }
                    }
                    callBack(nil)
                }
            } catch {
                DispatchQueue.main.async {
                    callBack(error)
                    print("caught: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func getMoreMessages(callBack: @escaping (_ : Error?) -> () ) {
        
        //self.messages = []
        let urlString = "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu&skip=" + String(messages.count)
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    for result in results.messages {
                        if let message = result as? Message {  //I know this always succedes, but it wont work without it
                            self.messages.append(message)
                        }
                    }
                    callBack(nil)
                }
            } catch {
                DispatchQueue.main.async {
                    callBack(error)
                    print("caught: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func postMessage(message: String) {
        let urlString = "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu&message=" + message
        let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        guard let endpointUrl = URL(string: escapedUrl!) else { return }
        
        do {
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request)
            task.resume()
        }
    }
    func postMessage(message: String, latitude: String, longitude: String) {
        let urlString = "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu&message=" + message + "&lat=" + latitude + "&lon=" + longitude
        let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        guard let endpointUrl = URL(string: escapedUrl!) else { return }
        
        do {
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request)
            task.resume()
        }
    }
    func likeMessage(messageID: String) {
        let urlString = "https://www.stepoutnyc.com/chitchat/like/" + messageID + "?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu"
        guard let url = URL(string: urlString) else { return }
        //print("URL")
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            print("data")
            guard let data = data else { return }
            
            do {
                print("We in the")
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(Like.self, from: data)
                if result.message != "Success" {
                    print("Error Handle Here")
                }
            } catch {
                print(error) //TODO Handle
            }
        }
        task.resume()
    }
    
    func dislikeMessage(messageID: String) {
        let urlString = "https://www.stepoutnyc.com/chitchat/dislike/" + messageID + "?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(Like.self, from: data)
                
                if result.message != "Success" {
                    print("Error Handle Here")
                }
            } catch {
                print(error) //TODO Handle
            }
        }
        task.resume()
    }
    
    func findMessageIDByRow(index: Int) -> String {
        return messages[index]._id
    }
    
    func findLatitueByRow(index: Int) -> String? {
        return messages[index].loc?[1]
    }
    
    func findLongitudeByRow(index: Int) -> String? {
        return messages[index].loc?[0]
    }
    func findLikesByRow(index: Int) -> Int {
        return messages[index].likes
    }
    func findDislikesByRow(index: Int) -> Int {
        return messages[index].dislikes
    }
    
    
    func syncData() {
        var encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: liked)
        UserDefaults.standard.set(encodedData, forKey: "liked")
        UserDefaults.standard.synchronize()
        
        encodedData = NSKeyedArchiver.archivedData(withRootObject: disliked)
        UserDefaults.standard.set(encodedData, forKey: "disliked")
        UserDefaults.standard.synchronize()
    }
    
    func loadUserData() {
        if UserDefaults.standard.object(forKey: "liked") != nil {
            let decoded = UserDefaults.standard.object(forKey: "liked") as! Data
            liked = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [String]
        }
        
        if UserDefaults.standard.object(forKey: "disliked") != nil {
            let decoded = UserDefaults.standard.object(forKey: "disliked") as! Data
            disliked = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [String]
        }
    }
}
