import Foundation

extension Bundle {
    private static var bundle:Bundle!
    
    public static func localizBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "ru"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        return bundle
    }
    
    
    public static func setLanguage(lang:String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
    
    public static func getLanguage()->String {
        return UserDefaults.standard.string(forKey: "app_lang") ?? "en"
    }
    
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self,tableName: nil,bundle: Bundle.localizBundle(),value: "", comment: "")
    }
    
    func localizeWithForm(arguments:CVarArg...) -> String {
        return String(format: self.localized(), arguments: arguments)
    }
}
