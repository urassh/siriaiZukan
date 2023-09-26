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
    
    public func getMembers() -> Array<Member> {
        return repository.getAllitems()
    }
    
    public func appendMember(_ member: Member) {
        repository.append(member)
    }
    
    public func deleteMember(_ member: Member) {
        imageResistry.deleteImage(id: member.id)
        repository.delete(member)
    }
    
    public func updateMember(before: Member, after: Member) {
        imageResistry.deleteImage(id: before.id)
        repository.update(before: before, after: after)
    }
    
    public func saveImage(image: UIImage, id: String) -> String? {
        guard let image = imageResistry.saveImage(image: image, id: id) else { return nil }
        return image
    }
    
    public func loadImage(member: Member) -> UIImage? {
        imageResistry.loadImage(id: member.id)
    }
}
