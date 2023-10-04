//
//  BackBlackView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/10/04.
//

import SwiftUI
import UIKit

struct BackBlackView<Content>: View where Content: View {
    @Environment(\.dismiss) var dismiss
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.8))
        .onTapGesture {
            dismiss()
        }
    }
}
