//
//  CommunityViewModel.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

import Foundation
import UIKit

class CommunityViewModel {
    private var repository: RealmRepository<Community>
    private var imageResistry: ImageResistry
    
    init() {
        self.repository = RealmRepository<Community>()
        self.imageResistry = ImageResistry()
    }
    
    public func getCommunities() -> Array<Community> {
        return repository.getAllitems()
    }
    
    public func appendCommunity(_ community: Community) {
        repository.append(community)
    }
    
    public func deleteCommunity(_ community: Community) {
        repository.delete(community)
    }
    
    public func updateCommunity(before: Community, after: Community) {
        repository.update(before: before, after: after)
    }
    
    public func saveImage(image: UIImage, id: String) -> String? {
        print("community id: \(id)")
        guard let image = imageResistry.saveImage(image: image, id: id) else { return nil }
        return image
    }
    
    public func loadImage(community: Community) -> UIImage? {
        imageResistry.loadImage(id: community.id)
    }
}
