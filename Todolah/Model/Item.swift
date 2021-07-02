//
//  Item.swift
//  Todolah
//
//  Created by Boon Kit Gan on 01/07/2021.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var category: String = "Pending"
    @objc dynamic var deadline: Date?
    @objc dynamic var isSelected: Bool = false
}
