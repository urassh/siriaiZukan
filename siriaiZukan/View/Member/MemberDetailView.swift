//
//  MemberDetailView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/12.
//

import SwiftUI
import MyLibrary

struct MemberDetailView: View {
    private let gradationColors: [String: GradationColor] = [
        "GradationColor_A": .colorA,
        "GradationColor_B": .colorB,
        "GradationColor_C": .colorC,
        "GradationColor_D": .colorD,
        "GradationColor_E": .colorE,
    ]
    
    @EnvironmentObject var viewState: MemberViewModel
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
             
                Text(viewState.selectMember!.name)
                    .font(.system(size: 52))
                    .foregroundStyle(Color("white95"))
                    .bold()
                
                Text(viewState.selectMember!.realName)
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
                            .overlay(CircularProgressBar(parameter: viewState.selectMember!.friendship.getParameter()))
                            .frame(maxHeight: 160)
                        
                        Button(action: {
                            withAnimation {
                                viewState.showDetailView = false
                                viewState.showEditView   = true
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
                    Text("\(viewState.selectMember!.name)について")
                        .font(.title)
                        .foregroundColor(Color("white95"))
                    
                    Text(viewState.selectMember!.about)
                        .foregroundStyle(Color("white65"))
                        .font(.caption)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: 320, maxHeight: 500)
            .background(gradationColors[viewState.selectMember!.gradation]?.getColor())
            .clipShape(
                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
            )
            .overlay(
                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)).strokeBorder(Color("white65"), lineWidth: 4)
            )
        }
    }
}

