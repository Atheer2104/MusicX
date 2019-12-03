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
   var header_image_thumbnail_url: String
   var url: String
   var title: String
   var lyrics_state: String
   var primary_artist: artist
   
}

struct artist: Codable {
   var name: String
}

