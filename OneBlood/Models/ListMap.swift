//
//  ListMap.swift
//  OneBlood
//
//  Created by Mac-Mini-2021 on 11/05/2022.
//

import Foundation


class listmap: NSObject {

    var Maptunis = [Information]()
    var MapBizert = [Information]()
    var MapBeja = [Information]()
    var MapNabeul = [Information]()
    var MapSousse = [Information]()
    var MapAll = [Information]()
    
    func AddTask()  {
    //tunis
        Maptunis.append(Information(Nom : "Centre National de Transfusion Sanguine",
                                    Location : "Djebel Lakhdar Bab Sâadoun Tunis",
                                    Numero : "71 573 884",
                                    Longitude : "10.1587826",
                                    Latitude : "36.808302",
                                    city : "Tunisia"))
        Maptunis.append(Information(
                                        Nom : "Banque du Sang de l'Hôpital La Rabta",
                                        Location : "Hôpital La Rabta 1006 Tunis",
                                        Numero : "71 578 819",
                                        Longitude : "10.1545699",
                                        Latitude : "36.801819800000004",
                            city : "Tunisia"))
        

        Maptunis.append(Information(    Nom : "Banque du Sang de l'Hôpital Charles Nicolle",
                                        Location : "Hôpital Charles Nicolle 1006 Tunis",
                                        Numero : "71 578 357",
                                        Longitude : "10.161216399999999",
                                        Latitude : "36.802265399999996"
        ,city : "Tunisia"))
        Maptunis.append(Information(   Nom : "Banque du Sang de l'Hôpital Habib Thameur",
                                       Location : "Hôpital Habib Thameur 1069 Tunis",
                                       Numero : "71 397 000",
                                       Longitude : "10.176554099999999",
                                       Latitude : "36.7860464"
                                       ,city : "Tunisia"))
        
        Maptunis.append(Information  ( Nom : "Centre Militaire de Transfusion Sanguine",
                        Location : "Ras Tabia, 2000 Le Bardo",
                        Numero : "71 564 466",
                        Longitude : "10.148322",
                        Latitude : "36.813266"
                        ,city : "Tunisia"))
        //bizert
        MapBizert.append(Information  (Nom : "Banque du Sang de l'Hôpital Régional de Bizerte",
                                       Location : "Hôpital Régional de Bizerte 7000 Bizerte",
                                       Numero : "72 422 057",
                                       Longitude : "9.8605322",
                                       Latitude : "37.2698447"
                                       ,city : "Bizerte"))
        MapBizert.append(Information  ( Nom : "Banque du Sang de l'Hôpital Régional de Menzel Bourguiba",
                                        Location : "Hopital Régional de Menzel Bourguiba 7050 Menzel Bourguiba",
                                        Numero : "72 460 455",
                                       Longitude : "9.796453699999999",
                                          Latitude : "37.161495099999996"
                                          ,city : "Bizerte"))
        MapBeja.append(Information  ( Nom : "Banque du Sang de l'Hôpital Régional de Béja",
                                      Location : "Hôpital Régional de Béja 9000 Béja",
                                      Numero : "78 457 322",
                                      Longitude : "9.179618999999999",
                                      Latitude : "36.721576999999996"
                                      ,city : "Béja"))
        MapNabeul.append(Information  (Nom : "Banque du Sang de l'Hôpital Régional de Nabeul",
                                     Location : "Hôpital Régional de Nabeul 8000 Nabeul",
                                     Numero : "72 285 633",
                                     Longitude : "10.731980799999999",
                                     Latitude : "36.4539014"
                                     ,city : "Nabeul"))
        MapNabeul.append(Information  ( Nom : "Banque du Sang de l'Hôpital Régional de Menzel Témime",
                                        Location : "Hôpital Régional de Menzel Témime 8080 Menzel Témime",
                                        Numero : "72 344 155",
                                        Longitude : "10.9976551",
                                        Latitude : "36.7785139"
                                        ,city : "Nabeul"))
        MapNabeul.append(Information  ( Nom : "Banque du Sang de l'Hôpital de Circonscription de Grombalia",
                                        Location : "Hôpital de Circonscription de Grombalia 8030 Grombalia",
                                        Numero : "72 255 212",
                                        Longitude : "10.494985",
                                        Latitude : "36.595185"
                                        ,city : "Nabeul"))
        MapSousse.append(Information  (  Nom : "Centre Régional de Transfusion Sanguine de Sousse",
                                         Location : "Hôpital Farhat Hached de Sousse 4000 Sousse",
                                         Numero : "73 223 311",
                                         Longitude : "10.627749399999999",
                                         Latitude : "35.8296103"
                                         ,city : "Sousse"))
        MapSousse.append(Information  ( Nom : "Banque du Sang de l'Hôpital Sahloul de Sousse",
                                        Location : "Hôpital Sahloul de Sousse 4000 Sousse",
                                        Numero : "73 369 411",
                                        Longitude : "10.5904807",
                                        Latitude : "35.837135599999996"
                                        ,city : "Sousse"))
        MapSousse.append(Information  (            Nom : "Banque du Sang de l'Hôpital Fattouma Bourguiba de Monastir",
                                                   Location : "Hôpital Fattouma Bourguiba de Monastir 5000 Monastir",
                                                   Numero : "73 460 411",
                                                   Longitude : "10.833765399999999",
                                                   Latitude : "35.7703318"
                                                   ,city : "Monastir"))
        MapSousse.append(Information  (  Nom : "Banque du Sang de l'Hôpital Régional de Ksar Hellal",
                                         Location : "Hôpital Régional de Ksar Hellal 5070 Ksar Hellal",
                                         Numero : "73 475 275",
                                         Longitude : "10.8889227",
                                         Latitude : "35.6507551"
                                         ,city : "Monastir"))
        MapSousse.append(Information  (    Nom : "Banque du Sang de l'Hôpital Régional de Mahdia",
                                           Location : "Hôpital Régional de Mahdia 5100 Mahdia",
                                           Numero : "3 671 744",
                                           Longitude : "11.0326427",
                                           Latitude : "35.5100753"
                                           ,city : "Mahdia"))
        
        
        //////alll
        MapAll.append(Information(Nom : "Centre National de Transfusion Sanguine",
                                    Location : "Djebel Lakhdar Bab Sâadoun Tunis",
                                    Numero : "71 573 884",
                                    Longitude : "10.1587826",
                                    Latitude : "36.808302",
                                    city : "Tunisia"
                                    
                                    
        ))
        MapAll.append(Information(
                                        Nom : "Banque du Sang de l'Hôpital La Rabta",
                                        Location : "Hôpital La Rabta 1006 Tunis",
                                        Numero : "71 578 819",
                                        Longitude : "10.1545699",
                                        Latitude : "36.801819800000004",
            city : "Tunisia"
            ))
        

        MapAll.append(Information(    Nom : "Banque du Sang de l'Hôpital Charles Nicolle",
                                        Location : "Hôpital Charles Nicolle 1006 Tunis",
                                        Numero : "71 578 357",
                                        Longitude : "10.161216399999999",
                                        Latitude : "36.802265399999996"
                                        ,city : "Tunisia"))
        MapAll.append(Information(   Nom : "Banque du Sang de l'Hôpital Habib Thameur",
                                       Location : "Hôpital Habib Thameur 1069 Tunis",
                                       Numero : "71 397 000",
                                       Longitude : "10.176554099999999",
                                       Latitude : "36.7860464"
                                       ,city : "Tunisia"))
        
        MapAll.append(Information  ( Nom : "Centre Militaire de Transfusion Sanguine",
                        Location : "Ras Tabia, 2000 Le Bardo",
                        Numero : "71 564 466",
                        Longitude : "10.148322",
                        Latitude : "36.813266"
                        ,city : "Tunisia"))
        //bizert
        MapAll.append(Information  (Nom : "Banque du Sang de l'Hôpital Régional de Bizerte",
                                       Location : "Hôpital Régional de Bizerte 7000 Bizerte",
                                       Numero : "72 422 057",
                                       Longitude : "9.8605322",
                                       Latitude : "37.2698447",
                                       city : "Bizerte"))
        MapAll.append(Information  ( Nom : "Banque du Sang de l'Hôpital Régional de Menzel Bourguiba",
                                        Location : "Hopital Régional de Menzel Bourguiba 7050 Menzel Bourguiba",
                                        Numero : "72 460 455",
                                       Longitude : "9.796453699999999",
                                          Latitude : "37.161495099999996",
                                          city : "Bizerte"))
        MapAll.append(Information  ( Nom : "Banque du Sang de l'Hôpital Régional de Béja",
                                      Location : "Hôpital Régional de Béja 9000 Béja",
                                      Numero : "78 457 322",
                                      Longitude : "9.179618999999999",
                                      Latitude : "36.721576999999996",city : "Béja"))
        MapAll.append(Information  (Nom : "Banque du Sang de l'Hôpital Régional de Nabeul",
                                     Location : "Hôpital Régional de Nabeul 8000 Nabeul",
                                     Numero : "72 285 633",
                                     Longitude : "10.731980799999999",
                                     Latitude : "36.4539014",
                                     city : "Nabeul"))
        MapAll.append(Information  ( Nom : "Banque du Sang de l'Hôpital Régional de Menzel Témime",
                                        Location : "Hôpital Régional de Menzel Témime 8080 Menzel Témime",
                                        Numero : "72 344 155",
                                        Longitude : "10.9976551",
                                        Latitude : "36.7785139",
                                        city : "Nabeul"))
        MapAll.append(Information  ( Nom : "Banque du Sang de l'Hôpital de Circonscription de Grombalia",
                                        Location : "Hôpital de Circonscription de Grombalia 8030 Grombalia",
                                        Numero : "72 255 212",
                                        Longitude : "10.494985",
                                        Latitude : "36.595185",
                                        city : "Nabeul"))
        MapAll.append(Information  (  Nom : "Centre Régional de Transfusion Sanguine de Sousse",
                                         Location : "Hôpital Farhat Hached de Sousse 4000 Sousse",
                                         Numero : "73 223 311",
                                         Longitude : "10.627749399999999",
                                         Latitude : "35.8296103",
                                         city : "Sousse"))
        MapAll.append(Information  ( Nom : "Banque du Sang de l'Hôpital Sahloul de Sousse",
                                        Location : "Hôpital Sahloul de Sousse 4000 Sousse",
                                        Numero : "73 369 411",
                                        Longitude : "10.5904807",
                                        Latitude : "35.837135599999996",
                                        city : "Sousse"))
        MapAll.append(Information  (            Nom : "Banque du Sang de l'Hôpital Fattouma Bourguiba de Monastir",
                                                   Location : "Hôpital Fattouma Bourguiba de Monastir 5000 Monastir",
                                                   Numero : "73 460 411",
                                                   Longitude : "10.833765399999999",
                                                   Latitude : "35.7703318",
                                                   city : "Monastir"))
        MapAll.append(Information  (  Nom : "Banque du Sang de l'Hôpital Régional de Ksar Hellal",
                                         Location : "Hôpital Régional de Ksar Hellal 5070 Ksar Hellal",
                                         Numero : "73 475 275",
                                         Longitude : "10.8889227",
                                         Latitude : "35.6507551",
                                         city : "Monastir"))
        MapAll.append(Information  (    Nom : "Banque du Sang de l'Hôpital Régional de Mahdia",
                                           Location : "Hôpital Régional de Mahdia 5100 Mahdia",
                                           Numero : "3 671 744",
                                           Longitude : "11.0326427",
                                           Latitude : "35.5100753",
                                           city : "Mahdia"))
        
        
        
        
 
    
    

    
    

    
    

        
         
  
      
    }
    
}

    
    
    
    




  

