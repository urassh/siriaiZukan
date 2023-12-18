//
//  MemberView.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/11/09.
//

import SwiftUI

extension AnyTransition {
    static func cardTransition() -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.opacity.combined(with: .offset(x: 100, y: 50)),
            removal  : AnyTransition.opacity.combined(with: .offset(x: -100, y: -50))
        )
    }
}

struct MemberView: View {
    public var community: Community
    private let members: [Member] = [.sample1, .sample2, .sample3, .sample1, .sample2, .sample3]
    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 100, maximum: 150))]
    @EnvironmentObject var viewState: MemberViewState
    
    private var showGround: Bool {
        viewState.showDetailView || viewState.showEditView
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
                        ForEach(members) { member in
                            CardView(member: member)
                                .onTapGesture {
                                    viewState.selectMember = member
                                    withAnimation {
                                        viewState.showDetailView = true
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
                                viewState.showDetailView = false
                                viewState.showEditView   = false
                            }
                        }
                }
                
                if viewState.showDetailView {
                    MemberDetailView()
                        .transition(.cardTransition())
                }
                
                if viewState.showEditView {
                    MemberEditView()
                        .transition(.cardTransition())
                }
            }
        }
        .navigationTitle(community.name)
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

#Preview {
    MemberView(community: .sample1)
        .environmentObject(MemberViewState())
}
