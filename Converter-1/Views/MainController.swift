//
//  ViewController.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import UIKit

class MainController: UIViewController {
    
    var viewModel = MainViewModel()
    
    @IBOutlet weak var editableAmountTextField: UITextField!
    @IBOutlet weak var finalAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightEditableAmountVIewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightFinalAmountViewConstraint: NSLayoutConstraint!
    
    var heightCells: CGFloat {
        return view.frame.size.height / 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editableAmountTextField.becomeFirstResponder()
        editableAmountTextField.addTarget(self, action: #selector(MainController.textFieldDidChange(_:)), for: .editingChanged)
        binding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        conversion()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        heightEditableAmountVIewConstraint.constant = heightCells
        heightFinalAmountViewConstraint.constant = heightCells
    }
    
    private func binding() {
        viewModel.editableAmount.bind { [weak self] in
            guard let string = $0 else { return }
            self?.finalAmountLabel.text = string
        }
    }
    
    /// protecting textField from incorrect data
    private func validationTextField(textField: UITextField) {
        if textField.text == "" || textField.text == "." {
            textField.text = "0"
        }
        if textField.text?.count ?? 0 > 1, textField.text?.prefix(1) == "0" {
            textField.text?.removeFirst()
        }
        if let countPoints = textField.text?.filter({ $0 == "." }).count {
            if countPoints > 1 {
                textField.text?.removeLast()
            }
        }
    }
    
    private func conversion() {
        viewModel.conversion(amount: editableAmountTextField.text ?? "0", from: "RU", to: ["EUR", "USD"]) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        validationTextField(textField: textField)
        viewModel.editableAmount.value = textField.text
        conversion()
    }
}


// MARK: extensions
extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellMainTableView", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(indexPath: indexPath)
        cell.configure()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCells
    }
}

