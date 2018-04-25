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
    
    
    func getMessages(callBack: @escaping (_ : Error?) -> () ) {
        messages.removeAll()
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
        let urlString = String(format: "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu&message=" + message)
        var escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        guard let endpointUrl = URL(string: escapedUrl!) else { return }
        print("url")
        do {
            print("in the do")
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            
            let task = URLSession.shared.dataTask(with: request)
            
            task.resume()

        }catch {
            DispatchQueue.main.async {
                //callBack(error)
                print("caught: \(error)")
            }
        }
        
    }
    
    
    func likeMessage(messageID: String) {
        let urlString = "https://www.stepoutnyc.com/chitchat/like/" + messageID + "?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu"
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
                print("OHNO")
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
    
}
