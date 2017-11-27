import UIKit

class CreditCardValidatorController: UIViewController, UITextFieldDelegate {

    let cardManager: APIManagerProtocol

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

        let apiManager = APIManager()
        cardManager = apiManager.createCreditCardManager()

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.edgesForExtendedLayout = []
        cardValidatorView().creditCardTextfield.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(observeValueText),
                                               name: NSNotification.Name.UITextFieldTextDidChange, object: nil)

    }
    
    @objc func observeValueText() {
        buttonConfiguration(textField: cardValidatorView().creditCardTextfield)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = CreditCardValidatorView()
    }

    private func cardValidatorView() -> CreditCardValidatorView {
        return self.view as! CreditCardValidatorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        cardValidatorView().creditCardTextfield.becomeFirstResponder()
        configureController()
    }

    private func configureController() {
        cardValidatorView().prepareView()
        prepareButtons()
        navigationBarSetup()
    }

    private func navigationBarSetup() {
        navigationItem.title = "Credit Card Validator"
        navigationController?.navigationBar.isTranslucent = true
    }

    private func prepareButtons() {
        cardValidatorView().generateCodeButton.addTarget(self, action: #selector(generateButtonAction), for: .touchUpInside)
        cardValidatorView().validateCodeButton.addTarget(self, action: #selector(validateButtonAction), for: .touchUpInside)
    }

    @objc private func generateButtonAction() {
        cardValidatorView().endEditing(true)
        cardValidatorView().validateCodeButton.alpha = 1.0
        cardValidatorView().validateCodeButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        cardValidatorView().validateCodeButton.isEnabled = true
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.cardValidatorView().generateCodeButton.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.cardValidatorView().generateCodeButton.transform = CGAffineTransform.identity
                        }
        })

        cardValidatorView().creditCardTextfield.text = ""
        cardValidatorView().creditCardTextfield.text = RandomCreditCardCodeGenerator().getFullCreditCardCodeWithSeparations()
    }

    @objc private func validateButtonAction() {
        cardValidatorView().endEditing(true)
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.cardValidatorView().validateCodeButton.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.cardValidatorView().validateCodeButton.transform = CGAffineTransform.identity
                        }
        })

        guard let code = cardValidatorView().creditCardTextfield.text else { return }
        let trimmedString = code.replacingOccurrences(of: " ", with: "")
        let codeFromTrimmedString = String(describing: trimmedString.prefix(16))

        cardValidatorView().validateCodeButton.isEnabled = false

        getCreditCardDataFromAPI(creditCardNumber: codeFromTrimmedString)
    }

    private func getCreditCardDataFromAPI(creditCardNumber: String) {
        DispatchQueue.global().async {
            self.getCreditCardDataFromRequestToAPI(with: creditCardNumber) { cardCode in
                if let data = cardCode[0] as? CreditCardModel {
                    DispatchQueue.main.async {
                        if !data.valid.isEmpty && data.valid == "true" {
                            self.cardValidatorView().succesValidationLabel.appear(alphaIn: 0.1, alphaOut: 1.0, duration: 0.5, delay: 0, scaleX: 0.8, scaleY: 0.8, onCompletion: { _ in
                                self.cardValidatorView().succesValidationLabel.disappear(alphaIn: 1.0, alphaOut: 0, duration: 1.0, delay: 0, scaleX: 1.0, scaleY: 1.0, onCompletion: {_ in
                                    self.cardValidatorView().validateCodeButton.isEnabled = true
                                })
                            })
                        } else {
                            self.cardValidatorView().failureValidationLabel.appear(alphaIn: 0, alphaOut: 1.0, duration: 0.5, delay: 0, scaleX: 0.8, scaleY: 0.8, onCompletion: { _ in
                                self.cardValidatorView().failureValidationLabel.disappear(alphaIn: 1.0, alphaOut: 0, duration: 1.0, delay: 0, scaleX: 1.0, scaleY: 1.0, onCompletion: {_ in
                                    self.cardValidatorView().validateCodeButton.isEnabled = true
                                })
                            })
                        }
                    }
                }
            }
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if string == "" || range.length > 0 { return true }
        
        let working = NSMutableString(string: textField.text ?? "")
        
        working.replaceCharacters(in: range, with: string)
        working.replaceOccurrences(of: " ", with: "", range: NSMakeRange(0, working.length))
        working.replaceOccurrences(of: "\n", with: "", range: NSMakeRange(0, working.length))

        if string == "-" || working.length > 24  { return false }

        var originalText = textField.text
        let replacementText = string.replacingOccurrences(of: "-", with: "")
        if !replacementText.containsOnlyDigits() { return false }

        if originalText?.count == 22 { originalText?.append("/") }
        if originalText?.count == 25 { originalText?.append(" ") }

        if (originalText?.count)! > 0 && (originalText?.count)! < 21 {
            if (originalText?.count)! < 5 && (originalText?.count)! % 4 == 0 {
                originalText?.append(" ")
            } else if(((originalText?.count)! + 1) % 5 == 0) {
                originalText?.append(" ")
            }
        }

        textField.text = originalText

        return true
    }

    func buttonConfiguration(textField: UITextField) {
        let working = NSMutableString(string: textField.text ?? "")
        
        working.replaceOccurrences(of: " ", with: "", range: NSMakeRange(0, working.length))
        working.replaceOccurrences(of: "\n", with: "", range: NSMakeRange(0, working.length))

        let userInteractionBool = working.length == 24
        if userInteractionBool {
            cardValidatorView().validateCodeButton.alpha = 1.0
            cardValidatorView().validateCodeButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cardValidatorView().validateCodeButton.isEnabled = true
        } else {
            cardValidatorView().validateCodeButton.alpha = 0.5
            cardValidatorView().validateCodeButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}
