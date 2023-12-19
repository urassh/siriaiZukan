//
//  MemberView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/09.
//

import SwiftUI

struct MemberView: View {
    @ObservedObject var viewModel: MemberViewModel
    
    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 100, maximum: 150))]
    
    private var showGround: Bool {
        viewModel.showDetailView || viewModel.showEditView
    }
    
    @ViewBuilder
    private func blackGround() -> some View {
        Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8))
            .ignoresSafeArea()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(viewModel.members) { member in
                            CardView(member: member)
                                .onTapGesture {
                                    viewModel.selectMember = member
                                    withAnimation {
                                        viewModel.showDetailView = true
                                    }
                                }
                        }
                    }
                    .padding()
                }
                
                if showGround {
                    blackGround()
                        .onTapGesture {
                            withAnimation {
                                viewModel.showDetailView = false
                                viewModel.showEditView   = false
                            }
                        }
                }
                
                if viewModel.showDetailView {
                    MemberDetailView(viewModel: $viewModel)
                        .transition(.cardTransition())
                }
                
                if viewModel.showEditView {
                    MemberEditView()
                        .transition(.cardTransition())
                }
            }
        }
        .navigationTitle(viewModel.community.name)
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
        .onAppear {
            viewModel.activate()
        }
        .onDisappear {
            viewModel.deactivate()
        }
    }
}
