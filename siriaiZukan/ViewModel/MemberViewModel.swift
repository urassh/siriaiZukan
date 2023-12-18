//
//  MemberViewModel.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/13.
//

import Foundation

class MemberViewModel: ObservableObject {
    @Published var members: [Member] = []
    @Published var showDetailView: Bool = false
    @Published var showEditView: Bool = false
    @Published var selectMember: Member?
    
    let community: Community
    
    init(community: Community) {
        self.community = community
    }
}
