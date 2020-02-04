//
//  SavedSong.swift
//  MusicX
//
//  Created by Atheer on 2020-02-02.
//  Copyright © 2020 Atheer. All rights reserved.
//

import Foundation
import CoreData

public class SavedSong: NSManagedObject, Identifiable  {
    @NSManaged public var title: String?
    @NSManaged public var artist: String?
    @NSManaged public var songLyricsUrl: String?
}

extension SavedSong {
    static func getAllSavedSongs() -> NSFetchRequest<SavedSong> {
        let request: NSFetchRequest<SavedSong> = SavedSong.fetchRequest() as! NSFetchRequest<SavedSong>
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
