import Foundation

public enum Track: UInt8, CaseIterable, Codable {
    case
    satieGymnopedies,
    mozartSymphony40,
    mozartEineKleineNachtmusik,
    mozartPrague,
    mozartPianoConcerto23,
    mozartRequiem,
    mozartSymphony1,
    mozartPianoSonata11,
    mozartPianoConcerto20,
    mozartElviraMadigan,
    mozartPianoConcerto22,
    mozartFantasia,
    beethovenMoonlightSonata,
    beethovenPathetique,
    beethovenSymphony2,
    beethovenSymphony9,
    beethovenPianoSonata1,
    beethovenPianoConcerto3,
    beethovenSymphony7,
    beethovenSymphony5,
    beethovenFurElise,
    brahmsSymphony3,
    debussyClairDeLune
    
    public var duration: TimeInterval {
        switch self {
        case .satieGymnopedies: return 210.15510204081633
        case .mozartSymphony40: return 473.3910204081633
        case .mozartEineKleineNachtmusik: return 346.04408163265305
        case .mozartPrague: return 631.04
        case .mozartPianoConcerto23: return 377.12979591836734
        case .mozartRequiem: return 409.2865306122449
        case .mozartSymphony1: return 169.37795918367348
        case .mozartPianoSonata11: return 852.8457142857143
        case .mozartPianoConcerto20: return 873.9004081632653
        case .mozartElviraMadigan: return 396.8783673469388
        case .mozartPianoConcerto22: return 617.0122448979591
        case .mozartFantasia: return 376.9469387755102
        case .beethovenMoonlightSonata: return 367.6473469387755
        case .beethovenPathetique: return 296.0195918367347
        case .beethovenSymphony2: return 619.075918367347
        case .beethovenSymphony9: return 928.0522448979592
        case .beethovenPianoSonata1: return 299.04979591836735
        case .beethovenPianoConcerto3: return 577.0710204081632
        case .beethovenSymphony7: return 856.9730612244898
        case .beethovenSymphony5: return 424.7248979591837
        case .beethovenFurElise: return 173.00897959183675
        case .brahmsSymphony3: return 547.1085714285714
        case .debussyClairDeLune: return 317.96244897959184
        }
    }
    
    public var composer: String {
        "track_\(self)_composer"
    }
    
    public var title: String {
        "track_\(self)_title"
    }
    
    public var file: String {
        "\(self)"
    }
}
