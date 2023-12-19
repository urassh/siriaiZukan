//
//  MemberDetailView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/12.
//

import SwiftUI
import MyLibrary

struct MemberDetailView: View {
    @Binding var viewModel: MemberViewModel
    
    private let gradationColors: [String: GradationColor] = [
        "GradationColor_A": .colorA,
        "GradationColor_B": .colorB,
        "GradationColor_C": .colorC,
        "GradationColor_D": .colorD,
        "GradationColor_E": .colorE,
    ]
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
             
                Text(viewModel.selectMember!.name)
                    .font(.system(size: 52))
                    .foregroundStyle(Color("white95"))
                    .bold()
                
                Text(viewModel.selectMember!.realName)
                    .font(.system(size: 24))
                    .foregroundStyle(Color("white65"))
                    .bold()
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    ZStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .overlay(CircularProgressBar(parameter: viewModel.selectMember!.friendship.getParameter()))
                            .frame(maxHeight: 160)
                        
                        Button(action: {
                            withAnimation {
                                viewModel.showDetailView = false
                                viewModel.showEditView   = true
                            }
                        }, label: {
                            Image(systemName: "pencil.circle")
                                .foregroundStyle(Color.cyan)
                                .background(Color("white95"))
                                .clipShape(Circle())
                                .font(.system(size: 40))
                                .padding(EdgeInsets(top: 120, leading: 120, bottom: 0, trailing: 0))
                        })
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(viewModel.selectMember!.name)について")
                        .font(.title)
                        .foregroundColor(Color("white95"))
                    
                    Text(viewModel.selectMember!.about)
                        .foregroundStyle(Color("white65"))
                        .font(.caption)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: 320, maxHeight: 500)
            .background(gradationColors[viewModel.selectMember!.gradation]?.getColor())
            .clipShape(
                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
            )
            .overlay(
                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)).strokeBorder(Color("white65"), lineWidth: 4)
            )
        }
    }
}

