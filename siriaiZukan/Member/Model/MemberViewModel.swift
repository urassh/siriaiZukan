//
//  MemberViewModel.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/23.
//

import Foundation
import UIKit

class MemberViewModel {
    private var repository: RealmRepository<Member>
    private var imageResistry: ImageResistry
    
    init() {
        self.repository = RealmRepository<Member>()
        self.imageResistry = ImageResistry()
    }
    
    public func getMember(_ community: Community, _ memberId: String?) -> Member? {
        guard let ID = memberId else { return nil }
        
        let memberArray = getMembers(community: community)
        for member in memberArray {
            if member.id == ID {
                return member
            }
        }
        
        return nil
    }
    
    public func getMembers(community: Community) -> Array<Member> {
        return repository.getAllitems().filter {
            $0.communityID == community.id
        }
    }
    
    public func appendMember(_ member: Member) {
        repository.append(member)
    }
    
    public func deleteMember(_ member: Member) {
        imageResistry.deleteImage(id: member.id)
        repository.delete(member)
    }
    
    public func updateMember(before: Member, after: Member) {
        after.id = before.id
        after.communityID = before.communityID
        repository.update(before: before, after: after)
    }
    
    public func saveImage(image: UIImage, id: String) -> String? {
        if loadImage(id) != nil {
            imageResistry.deleteImage(id: id)
        }
        
        guard let image = imageResistry.saveImage(image: image, id: id) else { return nil }
        return image
    }
    
    public func loadImage(_ id: String) -> UIImage? {
        imageResistry.loadImage(id: id)
    }
}
