//
//  MemberEditView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/12.
//

import SwiftUI
import MyLibrary

struct MemberEditView: View {
    private let gradationColors: [String: GradationColor] = [
        "GradationColor_A": .colorA,
        "GradationColor_B": .colorB,
        "GradationColor_C": .colorC,
        "GradationColor_D": .colorD,
        "GradationColor_E": .colorE,
    ]
    @EnvironmentObject var viewModel: MemberViewModel
    
    @State var name: String = ""
    @State var realName: String = ""
    @State var friendship: CGFloat = 0.0
    @State var aboutText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(CircularProgressBar(parameter: Float(friendship)))
                        .frame(maxHeight: 160)
                    
                    Spacer()
                }
             
                Spacer()
                
                VStack(alignment: .leading, spacing: 1.0) {
                    Text("Nick Name")
                        .font(.title3)
                        .foregroundStyle(Color("white95"))
                        .bold()
                    TextField((viewModel.selectMember != nil) ? viewModel.selectMember!.name : name, text: $name)
                        .textFieldStyle(.roundedBorder)
                        .opacity(0.6)
                        .background(Color.clear)
                        .font(.caption)
                        .frame(width: 180)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 1.0) {
                    Text("Real Name")
                        .font(.title3)
                        .foregroundStyle(Color("white95"))
                        .bold()
                    TextField((viewModel.selectMember != nil) ? viewModel.selectMember!.realName : realName, text: $realName)
                        .textFieldStyle(.roundedBorder)
                        .opacity(0.6)
                        .background(Color.clear)
                        .font(.caption)
                        .frame(width: 220)
                }
                
                Spacer()
                
                HStack {
                    Text("親密度")
                        .font(.title3)
                        .foregroundStyle(Color("white95"))
                        .bold()
                    
                    Slider(value: $friendship, in: 0...1.0)
                        .tint(.green)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\((viewModel.selectMember != nil) ? viewModel.selectMember!.name : "名無し")について")
                        .font(.title2)
                        .foregroundColor(Color("white95"))
                    
                    TextEditor(text: $aboutText)
                        .border(Color.gray, width: 1)
                        .overlay(alignment: .topLeading) {
                            if aboutText.isEmpty {
                                Text("この人物についてや、あなたとのエピソードについて書きましょう")
                                    .allowsHitTesting(false)
                                    .foregroundColor(Color(uiColor: .placeholderText))
                                    .padding(6)
                                    .font(.caption2)
                            }
                        }
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("white95"), lineWidth: 2)
                            )
                        .background(Color("white65"))
                        .font(.caption2)
                }
            }
            .padding()
            .frame(maxWidth: 320, maxHeight: 500)
            .background(
                (viewModel.selectMember != nil) ? gradationColors[viewModel.selectMember!.gradation]?.getColor() : GradationColor_A.colorA.getColor()
                
            )
            .clipShape(
                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
            )
            .overlay(
                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)).strokeBorder(Color("white65"), lineWidth: 4)
            )
        }
    }
}
