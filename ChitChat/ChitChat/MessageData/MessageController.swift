//
//  MessageController.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/14/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import Foundation



class Messages{
    var messages: [Message] = []
    init() {
        print("messages Init")
        getMessages();
    }
//    func getMessages() {
//        let request = URLRequest(url: NSURL(string: "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu")! as URL)
//        do {
//            // Perform the request
//            var response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
//            let data =  NSURLConnection.sendSynchronousRequest(request, returning: response)
//
//            // Convert the data to JSON
//            let jsonSerialized = JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//            catch Error{
//                print("ERROR")
//            }
//            if let json = jsonSerialized, let url = json["url"], let explanation = json["Messages"] {
//                print(url)
//                print(explanation)
//            }
//
//        }
//    }
    func getMessages2() {
        let urlString = "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if error != nil {
                print(error!.localizedDescription)
            }

            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {


//                let decoder = JSONDecoder()
//                let container = SingleValueDecodingContainer.self
//
//                let count = try decoder.container<Int>(keyedBy: Int.self)
//
//                //if let count : Int = try? container.decode(Int.self){
//                    print(count)
//                //}
//                //Decode retrived data with JSONDecoder and assing type of Article object
                let articlesData  = try JSONDecoder().decode([String: Int].self  , from: data)

                //dump(articlesData)
                print(articlesData)
                //Get back to the main queue
//                DispatchQueue.main.async {
//                    print(articlesData)
//                    //self.articles = articlesData
//                    //self.collectionView?.reloadData()
//                }

            } catch let jsonError {
                print("this", jsonError)
            }

            }.resume()
    }

    func getMessages() {
        print("func")
        let urlString = "https://www.stepoutnyc.com/chitchat?key=d37f5960-8655-40c2-b5fb-9f169da9ad28&client=morgan.seielstad@mymail.champlain.edu"
        guard let url = URL(string: urlString) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
        print("here")
        guard let data = data else { return }
            print("HMMM")
            do {
                let jsonDecoder = JSONDecoder()
                print("json")
                let results = try jsonDecoder.decode(Response.self, from: data)
                //print(results.count)
                //print(results.date)
                //print(results.messages)
                print("result")
                for result in results.messages {
                    if let message = result as? Message {
                        self.messages.append(message)
                    }
                }
            } catch {
                print("caught: \(error)")
            }
        }.resume()
    }
    
}
