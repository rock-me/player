import Foundation

public enum Track: UInt8, CaseIterable, Codable {
    case
    satieGymnopedies,
    beethovenMoonlightSonata,
    debussyClairDeLune,
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
    beethovenPathetique,
    beethovenSymphony2,
    beethovenSymphony9,
    beethovenPianoSonata1,
    beethovenPianoConcerto3,
    beethovenSymphony7,
    beethovenSymphony5,
    mozartFantasia,
    beethovenFurElise,
    brahmsSymphony3
    
    var duration: TimeInterval {
        switch self {
        default: return 120
        }
    }
}
