//
//  CardView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/09.
//

import SwiftUI
import MyLibrary

struct CardView: View {
    public let member: Member
    private let gradationColors: [String: GradationColor] = [
        "GradationColor_A": .colorA,
        "GradationColor_B": .colorB,
        "GradationColor_C": .colorC,
        "GradationColor_D": .colorD,
        "GradationColor_E": .colorE
    ]
    
    var body: some View {
        VStack (alignment: .center){
            Spacer()
            
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .overlay(
                    Circle().strokeBorder(Color("white65"), lineWidth: 3)
                )
                .frame(maxHeight: 80)
            
            Spacer()
            
            Text(member.name)
                .font(.title3)
                .foregroundColor(Color("white95"))
                .bold()
            
            Text(member.realName)
                .font(.caption)
                .foregroundColor(Color("white65"))
                .multilineTextAlignment(.center)
                .bold()

            Spacer()
        }
        .padding()
        .frame(maxWidth: 140, maxHeight: 200, alignment: .center)
        .background(gradationColors[member.gradation]?.getColor())
        .clipShape(
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
        )
        .overlay(
            RoundedRectangle(cornerSize: CGSize(width: 12, height: 12)).strokeBorder(Color("white65"), lineWidth: 4)
        )
    }
}
