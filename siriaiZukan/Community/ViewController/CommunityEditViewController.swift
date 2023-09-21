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
    
    let picker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if iconImage.image != nil {
            captureButton.isHidden = true
        }
        
        picker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if iconImage.image != nil {
            captureButton.isHidden = true
        }
    }
    
    @IBAction func iconButtonTapped() {
        ///ライブラリにアクセスし、ゲットした写真をiconImageに代入する処理。
        showAlert()
        print("button tapped")
    }
    
    @IBAction func registerTapped() {
        ///RealmにCommunity型のデータを格納する。
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "どの方法で画像を取得しますか？", message: "", preferredStyle: .actionSheet)
        let cameraSheet = UIAlertAction(title: "Camera", style: .default) { (action) in
            //ここにカメラの起動処理を書く。
            self.dismiss(animated: true, completion: nil)
        }
        
        let librarySheet = UIAlertAction(title: "Library", style: .default) { [self] (action) in
            present(picker, animated: true)
//            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cameraSheet)
        alert.addAction(librarySheet)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension CommunityEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let firstImage = info[.originalImage] as! UIImage
        iconImage.image = firstImage
        captureButton.isHidden = true
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


