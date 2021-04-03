//
//  ViewController.swift
//  RPNCalculator
//
//  Created by Samuel Goodwin on 4/3/21.
//

import UIKit

class ViewController: UICollectionViewController {

    let model: Model

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let url = nibBundleOrNil?.url(forResource: "example", withExtension: "csv")
        self.model = Model(input: try! String(contentsOf: url!))

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        let url = Bundle.main.url(forResource: "example", withExtension: "csv")
        self.model = Model(input: try! String(contentsOf: url!))

        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        model.rows
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.columns
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spreadsheetCell", for: indexPath) as! SpreadsheetCell

        cell.label.text = model.value(at: indexPath)

        return cell
    }
}

