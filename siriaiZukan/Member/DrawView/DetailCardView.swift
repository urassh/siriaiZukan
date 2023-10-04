//
//  DetailCardView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/10/04.
//

import SwiftUI
import UIKit

struct DetailCardView: View {
    @Environment(\.dismiss) var dismiss
    @State var isShowEditView = false
    @State var isShowAlert    = false
    @State var member: Member?
    
    public  var community: Community!
    public  var memberId: String!
    private var viewModel: MemberViewModel = MemberViewModel()

    init(community: Community, memberId: String) {
        self.community = community
        self.memberId  = memberId
    }
    
    private let gradients = [
        LinearGradient(gradient: Gradient(colors: [.purple, .cyan.opacity(0.9)]), startPoint: .topTrailing, endPoint: .bottomLeading),
        LinearGradient(gradient: Gradient(colors: [.pink, .orange.opacity(0.8)]), startPoint: .topTrailing, endPoint: .bottomLeading),
        LinearGradient(gradient: Gradient(colors: [.cyan, .blue.opacity(0.8)]), startPoint: .topTrailing, endPoint: .bottomLeading),
        LinearGradient(gradient: Gradient(colors: [.mint, .green.opacity(0.8)]), startPoint: .topTrailing, endPoint: .bottomLeading),
        LinearGradient(gradient: Gradient(colors: [.orange, .yellow.opacity(0.8)]), startPoint: .topTrailing, endPoint: .bottomLeading),
    ]
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("\(member?.nickName ?? "???")")
                        .foregroundColor(.white)
                        .font(.system(size: 46))
                        .fontWeight(.bold)
                        .opacity(0.9)
                    
                    Text("\(member?.name ?? "???")")
                        .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8))
                        .font(.title3)
                }
                
                Spacer()
                
                Button(action: {
                    isShowAlert.toggle()
                }, label: {
                    Image(systemName: "ellipsis")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                })
            }.padding()
                        
            Image(uiImage: viewModel.loadImage(memberId) ?? UIImage(systemName: "person.fill")!)
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 6)
                        .opacity(0.6)
                )
        
            VStack(alignment: .leading, spacing: 10) {
                Text("\(member?.nickName ?? "この人物")について")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.title)
                    .opacity(0.9)
                Text("\(member?.about ?? "この人物についての情報はまだ設定されていません。")")
                    .font(.caption)
                    .foregroundColor(.white)
                    .opacity(0.9)
            }.padding()
                .frame(width: 300, height: 100,alignment: .leading)
            Spacer()
        }
            .frame(width: 300, height: 500)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(gradients[0])
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white, lineWidth: 6)
                    )
                )
            .alert("プロフィール変更", isPresented: $isShowAlert) {
                Button("編集", action: {
                    isShowEditView.toggle()
                    isShowAlert.toggle()
                })
                
                Button("削除", role: .destructive, action: {
                    //メンバー削除
                    if let unwrapMember = member {
                        viewModel.deleteMember(unwrapMember)
                    }
                    //MemberViewControllerに遷移。
                    
                    
                    isShowAlert.toggle()
                })
                
                Button("キャンセル", role: .cancel, action: {
                    isShowAlert.toggle()
                })
            }
            .onAppear(perform: {
                member = viewModel.getMember(community, memberId)
            })
            .sheet(isPresented: $isShowEditView) {
                MemberEditView(community: community, memberId: memberId)
            }
    }
}
