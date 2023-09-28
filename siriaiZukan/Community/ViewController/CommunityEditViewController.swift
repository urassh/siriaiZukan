//
//  CommunityEditViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//
import UIKit

class CommunityEditViewController: UIViewController {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var defaultLabel: UILabel!
    @IBOutlet var captureButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var personTextField: UITextField!
    
    public var previousCommunity: Community?
    private var community: Community!
    private let picker    = UIImagePickerController()
    private let viewModel = CommunityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        community = Community()
        

        if let unwrapCommunity = previousCommunity,
           let unwrapImage = viewModel.loadImage(unwrapCommunity.id)
        {
            iconImage.image = treatIconImage(unwrapImage)
            defaultLabel.isHidden = true
        } else {
            iconImage.image = treatIconImage(UIImage(systemName: "person.fill")!)
        }
        
        nameTextField.text = previousCommunity?.name
        personTextField.text = String(previousCommunity?.persons ?? 0)
        picker.delegate = self
    }
    
    @IBAction func iconButtonTapped() {
        showAlert()
    }
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func registerTapped() {
        guard let unwrapImage = iconImage.image    else { return }
        guard let unwrapName  = nameTextField.text else { return }
        guard let unwrapPersons = personTextField.text else { return }
        guard let savedImage  = viewModel.saveImage(image: unwrapImage, id: community.id) else { return }
        
        community.name  = unwrapName
        community.persons = Int(unwrapPersons) ?? 0
        
        if let previous = previousCommunity {
            community.image = viewModel.saveImage(image: unwrapImage, id: previous.id)!
            viewModel.updateCommunity(before: previousCommunity!, after: community)
        } else {
            community.image = viewModel.saveImage(image: unwrapImage, id: community.id)!
            viewModel.appendCommunity(community)
        }
        
        let storyboard: UIStoryboard = self.storyboard!
        let communityView = storyboard.instantiateViewController(withIdentifier: "communityVC") as! CommunityViewController

        self.navigationController?.pushViewController(communityView, animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "どの方法で画像を取得しますか？", message: "", preferredStyle: .actionSheet)
        let cameraSheet = UIAlertAction(title: "Camera", style: .default) { [self] (action) in
            self.picker.sourceType = .camera
            present(picker, animated: true)
        }
        
        let librarySheet = UIAlertAction(title: "Library", style: .default) { [self] (action) in
            self.picker.sourceType = .photoLibrary
            present(picker, animated: true)
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alert.addAction(cameraSheet)
        alert.addAction(librarySheet)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func treatIconImage(_ image: UIImage) -> UIImage{
        image
            .resizable(toSize: CGSize(width: 200, height: 200))
            .roundedCorners(radius: 10)
    }
}

extension CommunityEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let firstImage = info[.originalImage] as! UIImage
        iconImage.image = treatIconImage(firstImage)
        defaultLabel.isHidden = true
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
