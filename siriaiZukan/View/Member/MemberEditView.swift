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
    @State private var newMember: Member?
    private var editingMember: Member? {
        viewModel.selectMember == nil ? newMember! : viewModel.selectMember
    }
    
    init() {
        if let _ = viewModel.selectMember {
            newMember = .newMember(communityID: viewModel.community.id)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                Spacer()
                
                HStack {
                    Spacer()
                    
                    MemberIcon(member: editingMember!)
                    
                    Spacer()
                }
             
                Spacer()
                
                VStack(alignment: .leading, spacing: 1.0) {
                    Text("Nick Name")
                        .font(.title3)
                        .foregroundStyle(Color("white95"))
                        .bold()
                    TextField("Enter Nickname", text: Binding(
                        get: {
                            editingMember!.name
                        }, set: { newValue in
                            if viewModel.selectMember == nil {
                                newMember!.name = newValue
                            } else {
                                viewModel.selectMember?.name = newValue
                            }
                        }
                    ))
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
                    TextField("Enter Real name", text: Binding(
                        get: {
                            editingMember!.realName
                        }, set: { newValue in
                            if viewModel.selectMember == nil {
                                newMember!.realName = newValue
                            } else {
                                viewModel.selectMember?.realName = newValue
                            }
                        }
                    ))
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
                    
                    Slider(value: Binding(get: {
                        editingMember!.friendship.getParameter()
                    }, set: { newValue in
                        if viewModel.selectMember == nil {
                            newMember!.friendship = .init(newValue)
                        } else {
                            viewModel.selectMember!.friendship = .init(newValue)
                        }
                    }), in: 0...1.0)
                        .tint(.green)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(editingMember!.name)について")
                        .font(.title2)
                        .foregroundColor(Color("white95"))
                    
                    TextEditor(text: Binding(get: {
                        editingMember!.about
                    }, set: { newValue in
                        if viewModel.selectMember == nil {
                            newMember!.about = newValue
                        } else {
                            viewModel.selectMember!.about = newValue
                        }
                    }))
                        .border(Color.gray, width: 1)
                        .overlay(alignment: .topLeading) {
                            if editingMember!.about.isEmpty {
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
                gradationColors[editingMember!.gradation]?.getColor()
                
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
