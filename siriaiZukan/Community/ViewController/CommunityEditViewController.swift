//
//  CommunityEditViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

///next: ライブラリにアクセスして、アイコン画像を保存する処理を書く。

import UIKit

class CommunityEditViewController: UIViewController {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var captureButton: UIButton!
    @IBOutlet var nameTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        if iconImage.image != nil {
            captureButton.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if iconImage.image != nil {
            captureButton.isHidden = true
        }
    }
    
    @IBAction func iconButtonTapped() {
        ///ライブラリにアクセスし、ゲットした写真をiconImageに代入する処理。
    }
    
    @IBAction func registerTapped() {
        ///RealmにCommunity型のデータを格納する。
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UIImage {
    func roundedCorners(radius: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: self.size).image { context in
            let rect = context.format.bounds
            let roundedPath = UIBezierPath(roundedRect: rect,
                                           cornerRadius: radius)
            roundedPath.addClip()
            // UIImageを描画
            draw(in: rect)
        }
    }
}
