//
//  MemberIcon.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/12/24.
//

import Foundation
import SwiftUI

struct MemberIcon: View {
    var member: Member
    var setMemberIcon: Bool = false
    
    init(member: Member) {
        self.member = member
        if (member.imagePath == "person.fill") {
            setMemberIcon = true
        }
    }
    
    var body: some View {
        VStack {
            if setMemberIcon {
                Image(member.imagePath)
                    .memberIconModifier(member: member)
            } else {
                Image(systemName: "person.fill")
                    .memberIconModifier(member: member)
            }
        }
    }
}

