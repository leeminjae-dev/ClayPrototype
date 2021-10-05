//
//  Transition.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/04.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading)
                .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal) } }
