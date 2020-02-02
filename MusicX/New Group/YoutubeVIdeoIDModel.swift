//
//  YoutubeVIdeoIDModel.swift
//  MusicX
//
//  Created by Atheer on 2020-01-28.
//  Copyright © 2020 Atheer. All rights reserved.
//

import Foundation

struct topLevel: Codable {
  var kind: String
  var regionCode: String
  var items: [item]
}


struct item: Codable {
  var kind: String
  var etag: String
  var id: ID

}


struct ID: Codable {
  var videoId: String
}
