//
//  ImageResistry.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

import Foundation
import UIKit

class ImageResistry {
    private let fileManager = FileManager.default
    
    private func getDocumentsURL(_ fileName:String) -> URL? {
        print("fileName : \(fileName)")
        
        do {
            let docsUrl = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            let url = docsUrl.appendingPathComponent(fileName)
            print(url)
            return url
        } catch {
            return nil
        }
    }
    
    public func saveImage(image: UIImage, id: String) -> String?{
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        
        do {
            try imageData.write(to: getDocumentsURL("\(id).jpg")!)
            
            if loadImage(id: id) == nil {
                print("読み込みに失敗しました")
            } else {
                print("読み込みに成功しました")
            }
            
            return "\(id).jpg"
        } catch {
            print("画像が保存できませんでした。\(error)")
            return nil
        }
    }
    
    public func loadImage(id: String) -> UIImage? {
        let path = getDocumentsURL("\(id).jpg")!.path
        if fileManager.fileExists(atPath: path) {
            if let image = UIImage(contentsOfFile: path) {
                return image
            } else {
                return nil
            }
        }else {
            return nil
        }
    }
    
    public func deleteImage(id: String) {
        let url = getDocumentsURL("\(id).jpg")!
        do {
            try fileManager.removeItem(at: url)
        } catch {
            print("削除失敗")
        }
    }
}
