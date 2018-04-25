//
//  Message.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/14/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import Foundation


class Response : Decodable {
    var count: Int = 20
    var date: String = ""
    var messages: [Message] = []
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.date = try container.decode(String.self, forKey: .date)
        self.messages = try container.decode([Message].self, forKey: .messages)
    }
    
    private enum CodingKeys: String, CodingKey {
        case count
        case date
        case messages
    }
}

class Message : Decodable {
    var _id: String = ""
    var client: String = ""
    var dates: String = ""
    var dislikes: Int = 0
    var ip : String = ""
    var likes: Int = 0
    var loc: [String] = []
    var message: String = ""
    
//    init(_id: String, client: String, date: String, dislikes: Int, ip: String, likes: Int,
//                loc: [String], message: String) {
//        self._id = _id
//        self.client = client
//        self.date = date
//        self.dislikes = dislikes
//        self.ip = ip;
//        self.likes = likes
//        self.loc = loc
//        self.message = message
//    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.client = try container.decode(String.self, forKey: .client)
        self.dates = try container.decode(String.self, forKey: .date)
        self.dislikes = try container.decode(Int.self, forKey: .dislikes)
        self.ip = try container.decode(String.self, forKey: .ip)
        self.likes = try container.decode(Int.self, forKey: .likes)
        do {self.loc = try container.decode([String].self, forKey: .loc)}  //some messages do not have this so we need a default. 
                catch{self.loc =  ["0","0"]}
        self.message = try container.decode(String.self, forKey: .message)
    }

    
    private enum CodingKeys: String, CodingKey {
        case _id
        case client
        case date
        case dislikes
        case ip
        case likes
        case loc
        case message
    }
}


