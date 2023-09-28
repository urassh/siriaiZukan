//
//  MemberViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

import UIKit



class MemberViewController: UIViewController {
    public var community: Community!
    @IBOutlet var achievementLabel: UILabel!
    @IBOutlet var registerLabel: UILabel!
    @IBOutlet var memberCollectionView: UICollectionView!
    private var memberArray: Array<Member>!
    private var viewModel: MemberViewModel = MemberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memberArray = viewModel.getMembers(community: community)
        memberCollectionView.dataSource = self
        memberCollectionView.delegate   = self
        navigationItem.title = community.name
        
        memberCollectionView.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "memberCollectioinViewCell")
    }
    
    @IBAction func tappedAddButton() {
        transEditView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadView()
    }
    
    private func transEditView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let memberEditVC = storyboard.instantiateViewController(withIdentifier: "MemberEditViewController") as! MemberEditViewController
        
        memberEditVC.community = community
        memberEditVC.modalPresentationStyle = .formSheet
        memberEditVC.presentationController?.delegate = self
        present(memberEditVC, animated: true)
    }
    
    private func transDetailView(member: Member) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let memberDetailVC = storyboard.instantiateViewController(withIdentifier: "MemberDetailViewController") as! MemberDetailViewController
        
        memberDetailVC.memberId = member.id
        memberDetailVC.community = community
        memberDetailVC.modalPresentationStyle = .formSheet
        memberDetailVC.presentationController?.delegate = self
        present(memberDetailVC, animated: true)
    }
    
    private func reloadView() {
        memberArray = viewModel.getMembers(community: community)
        registerLabel.text = memberArray.count == community.persons ? "Complete!!" : "\(memberArray.count)人登録 (\(community.persons)人中)"
        memberArray = viewModel.getMembers(community: community)
        memberCollectionView.reloadData()
    }
    
    private func treatIconImage(_ image: UIImage) -> UIImage {
        image
            .resizable(toSize: CGSize(width: 200, height: 200))
            .roundedCorners(radius: 100)
    }
}

extension MemberViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memberArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memberCollectioinViewCell", for: indexPath) as? MemberCollectionViewCell else { return UICollectionViewCell() }
        
        let member = memberArray[indexPath.row]
        var iconImage = UIImage()
        
        if let unwrapImage = viewModel.loadImage(member.id) {
            iconImage = treatIconImage(unwrapImage)
        } else {
            iconImage = treatIconImage(UIImage(systemName: "person.fill")!)
        }
        
        cell.setupInfo(icon: iconImage, nickName: member.nickName, realName: member.name)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSizeWidth: CGFloat = 80.0
        let cellSizeHeight: CGFloat = 140.0
        return CGSize(width: cellSizeWidth, height: cellSizeHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("member: \(memberArray[indexPath.row])")
        transDetailView(member: memberArray[indexPath.row])
    }
}

extension MemberViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        reloadView()
    }
}
