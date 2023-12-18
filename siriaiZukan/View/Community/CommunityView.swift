//
//  ContentView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/08.
//

import SwiftUI

struct CommunityView: View {
    private let communities = [
        Community(name: "Life is Tech!", imagePath: ""),
        Community(name: "Tokyo City Univercity", imagePath: ""),
        Community(name: "Gast", imagePath: "")
    ];
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(communities, id: \.self) { commuunity in
                    NavigationLink(destination: {
                        MemberView(community: commuunity)
                            .environmentObject(MemberViewModel())
                    }, label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .leading)
                        Text(commuunity.name)
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    })
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            //Communityを削除する
                        } label: {
                            Text("削除")
                        }
                        .tint(.red)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        NavigationLink(destination: {
                            CommunityEditView(nameTextField: "")
                        }, label: {
                            Text("編集")
                        }).tint(.blue)
                    }
                }
                .navigationTitle("Community")
                .toolbar(content: {
                    NavigationLink(destination: {
                        CommunityEditView(nameTextField: "")
                    }, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24, alignment: .leading)
                    })
                })
            }
        }
    }
}

#Preview {
    CommunityView()
}
