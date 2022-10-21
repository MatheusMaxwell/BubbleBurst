//
//  ViewExtension.swift
//  BubbleBurst
//
//  Created by Matheus Maxwell Meireles on 15/09/22.
//

import SwiftUI

extension View {
    func hiddenConditionally(isHidden: Bool) -> some View {
        isHidden ? AnyView(self.hidden()) : AnyView(self)
    }
}
