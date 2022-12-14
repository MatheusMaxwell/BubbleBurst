//
//  Binding.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 14/09/22.
//

import Foundation
import SwiftUI

extension Binding {
    init<ObjectType: AnyObject>(
        to path: ReferenceWritableKeyPath<ObjectType, Value>,
        on object: ObjectType
    ) {
        self.init(
            get: { object[keyPath: path] },
            set: { object[keyPath: path] = $0 }
        )
    }
}
