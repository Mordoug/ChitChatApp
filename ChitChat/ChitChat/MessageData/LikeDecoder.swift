//
//  LikeDecoder.swift
//  ChitChat
//
//  Created by Seielstad, Morgan on 4/19/18.
//  Copyright © 2018 Seielstad, Morgan. All rights reserved.
//

import Foundation


class Like : Decodable {
    var code : Int = 0
    var id : String = ""
    var message: String = ""
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: .code)
        self.id = try container.decode(String.self, forKey: .id)
        self.message = try container.decode(String.self, forKey: .message)
    }
    
    private enum CodingKeys: String, CodingKey {
        case code
        case id
        case message
    }
    
    
}

class Post : Decodable {
    var code : Int = 0
    var message : String = ""
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
    }
    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}


