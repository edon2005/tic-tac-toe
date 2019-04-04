//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created on 03/04/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import UIKit
import EasyPeasy

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var model = ModelBoard()
    
    let statusLabel = UILabel()
    let startButton = UIButton()
    var currentStep = BoardCellType.none {
        didSet {
            statusLabel.text = "Choose cell for " + currentStep.value
        }
    }
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startGame()
    }
    
    private func setupView() {
        [statusLabel, startButton, collectionView].forEach(view.addSubview)
        startButton.easy.layout(Top(30).to(view.safeAreaLayoutGuide, .top), Left(10))
        statusLabel.easy.layout(Top(30).to(view.safeAreaLayoutGuide, .top), CenterX())
        collectionView.easy.layout(Center(), Width().like(view), Height().like(view, .width))
        collectionView.backgroundColor = .black
        collectionView.register(LabelCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self

        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        statusLabel.font = UIFont.systemFont(ofSize: 30)
        startButton.setTitle("Restart", for: .normal)
        startButton.backgroundColor = .blue
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }

    @objc private func startGame() {
        currentStep = .x
        model = ModelBoard()
        collectionView.reloadData()
        collectionView.isUserInteractionEnabled = true
    }
    
    private func stopGame() {
        collectionView.isUserInteractionEnabled = false
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model.grid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.grid[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LabelCell
        cell.label.text = model.grid[indexPath.section][indexPath.row].value
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        let height = collectionView.bounds.height / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return model.grid[indexPath.section][indexPath.row] == .none
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        model.grid[indexPath.section][indexPath.row] = currentStep
        collectionView.reloadData()
        if model.isWinner(currentStep) {
            statusLabel.text = "Winner is: " + currentStep.value
            stopGame()
        } else {
            if model.isEmptyCell() {
                currentStep = currentStep.antiState
            } else {
                statusLabel.text = "Nobody wins"
                stopGame()
            }
        }
    }
}
