//
//  CommunityEditView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/09.
//

import SwiftUI

struct CommunityEditView: View {
    @State var nameTextField: String
    @FocusState private var nameTextFieldIsFocused: Bool
    
    var body: some View {
        VStack (spacing: 30){
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
            
            TextField("あなたが所属しているグループを入力しよう", text: $nameTextField)
                .textFieldStyle(.roundedBorder)
                .focused($nameTextFieldIsFocused)
                .frame(width: 300, height: 50)
                .font(.system(size: 14))
            
            Button(action: {
                
            }, label: {
                Text("Register")
                    .frame(width: 200, height: 50)
                    .background(.orange)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)))
            })
            
        }
    }
}
