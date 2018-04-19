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
       
        let urlString = "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu"
        guard let url = URL(string: urlString) else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(Response.self, from: data)
                print(results.count)
                
                DispatchQueue.main.async {
                    for result in results.messages {
                        if let message = result as? Message {  //I know this always succedes, but it wont work without it?
                            print(message)
                            self.messages.append(message)
                            print(self.messages.count)
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
    
}
