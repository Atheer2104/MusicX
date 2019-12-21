//
//  GeniusAPIModel.swift
//  MusicX
//
//  Created by Atheer on 2019-11-13.
//  Copyright © 2019 Atheer. All rights reserved.
//

import Foundation

struct feed: Codable {
   var meta: meta
   var response: response
}

struct meta: Codable {
   var status: Int
}

struct response: Codable {
   var hits: [hits]
}

struct hits: Codable {
   var index: String
   var type: String
   var result: song
}

struct song: Codable, Identifiable {
   var id: Int
   var imageUrl: String
   var lyricsUrl: String
   var title: String
   var lyrics_state: String
   var primary_artist: artist
    
    private enum CodingKeys: String, CodingKey{
    case id
    case imageUrl = "header_image_thumbnail_url"
    case lyricsUrl = "url"
    case title
    case lyrics_state
    case primary_artist
    }
    
   
}

struct artist: Codable {
   var name: String
}

