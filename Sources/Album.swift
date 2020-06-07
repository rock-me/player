import Foundation

public enum Album: UInt8, Codable, CaseIterable {
    case
    mists,
    melancholy,
    tension,
    dawn
    
    public var tracks: [Track] {
        switch self {
        case .mists: return [
            .satieGymnopedies,
            .mozartRequiem,
            .mozartPrague,
            .mozartPianoConcerto22,
            .beethovenPathetique]
        case .melancholy: return [
            .beethovenMoonlightSonata,
            .debussyClairDeLune,
            .mozartPianoConcerto23,
            .mozartElviraMadigan,
            .beethovenSymphony7,
            .beethovenFurElise]
        case .tension: return [
            .mozartSymphony40,
            .mozartPianoConcerto20,
            .beethovenSymphony9,
            .beethovenSymphony2,
            .beethovenSymphony5,
            .brahmsSymphony3]
        case .dawn: return [
            .mozartEineKleineNachtmusik,
            .mozartSymphony1,
            .mozartPianoSonata11,
            .beethovenPianoSonata1,
            .beethovenPianoConcerto3,
            .mozartFantasia]
        }
    }
    
    public var duration: TimeInterval {
        tracks.map(\.duration).reduce(0, +)
    }
    
    public var purchase: String {
        "rock.me.album.\(self)"
    }
    
    public var title: String {
        "album_\(self)_title"
    }
    
    public var subtitle: String {
        "album_\(self)_subtitle"
    }
    
    public var cover: String {
        "album_\(self)"
    }
}
