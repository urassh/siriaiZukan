//
//  ContentView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/08.
//

import SwiftUI

struct CommunityView: View {
    @StateObject var viewModel: CommunityViewModel<CommunityDatabase>
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.communities) { community in
                    NavigationLink(destination: {
                        MemberView()
                            .environmentObject(MemberViewModel(community: community))
                    }, label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .background(Color(uiColor: UIColor.lightGray))
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 6, height: 6)))
                        Text(community.name)
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
        .onAppear {
            viewModel.activate()
        }
        .onDisappear {
            viewModel.deactivate()
        }
    }
}
