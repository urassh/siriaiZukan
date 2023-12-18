//
//  MemberViewState.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/13.
//

import Foundation

class MemberViewState: ObservableObject {
    @Published var selectMember: Member?
    @Published var showDetailView: Bool = false
    @Published var showEditView: Bool   = false
}
