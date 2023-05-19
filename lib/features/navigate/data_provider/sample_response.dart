const String response = """{
    "requestParameters": {
        "date": "2023-05-17",
        "walkSpeed": "1.34",
        "fromPlace": "Sunshine Apartments, YK_13_0605 St., Yedejazmach Alula Irsha, Addis Ababa, 5648, Ethiopia::9.019495739272315,38.853185470085094",
        "maxWalkDistance": "1609",
        "batchId": "4o8l71cu8",
        "otherThanPreferredRoutesPenalty": "900",
        "numItineraries": "3",
        "mode": "WALK,TRANSIT",
        "arriveBy": "false",
        "ignoreRealtimeUpdates": "false",
        "showIntermediateStops": "true",
        "toPlace": "Bekele Weya Street, Lideta, Addis Ababa, 7777, Ethiopia::9.010909331320804,38.73371304571623",
        "time": "11:44"
    },
    "plan": {
        "date": 1684313040000,
        "from": {
            "name": "Sunshine Apartments, YK_13_0605 St., Yedejazmach Alula Irsha, Addis Ababa, 5648, Ethiopia",
            "lon": 38.8531855,
            "lat": 9.0194957,
            "vertexType": "NORMAL"
        },
        "to": {
            "name": "Bekele Weya Street, Lideta, Addis Ababa, 7777, Ethiopia",
            "lon": 38.733713,
            "lat": 9.0109093,
            "vertexType": "NORMAL"
        },
        "itineraries": [
            {
                "duration": 3503,
                "startTime": 1684315260000,
                "endTime": 1684318763000,
                "walkTime": 729,
                "transitTime": 2474,
                "waitingTime": 300,
                "walkDistance": 899.49,
                "walkLimitExceeded": false,
                "generalizedCost": 4756,
                "elevationLost": 0,
                "elevationGained": 0,
                "transfers": 0,
                "fare": {
                    "fare": {},
                    "details": {}
                },
                "legs": [
                    {
                        "startTime": 1684315260000,
                        "endTime": 1684315697000,
                        "departureDelay": 0,
                        "arrivalDelay": 0,
                        "realTime": false,
                        "distance": 544.2,
                        "generalizedCost": 834,
                        "pathway": false,
                        "mode": "WALK",
                        "transitLeg": false,
                        "route": "",
                        "agencyTimeZoneOffset": 10800000,
                        "interlineWithPreviousLeg": false,
                        "from": {
                            "name": "Sunshine Apartments, YK_13_0605 St., Yedejazmach Alula Irsha, Addis Ababa, 5648, Ethiopia",
                            "lon": 38.8531855,
                            "lat": 9.0194957,
                            "departure": 1684315260000,
                            "vertexType": "NORMAL"
                        },
                        "to": {
                            "name": "C.M.C",
                            "stopId": "1:1:way/604046026",
                            "lon": 38.8504558,
                            "lat": 9.0210263,
                            "arrival": 1684315697000,
                            "departure": 1684315997000,
                            "vertexType": "TRANSIT"
                        },
                        "legGeometry": {
                            "points": "yr`v@_pclFE?]A?f@AVElB]EUEEAICWKa@SJb@Fd@Ef@Qb@OPCBWN_@La@BE?e@GOGOI\\\\hADXBVAl@A~@A\\\\R?",
                            "length": 32
                        },
                        "steps": [
                            {
                                "distance": 192.78,
                                "relativeDirection": "DEPART",
                                "streetName": "road",
                                "absoluteDirection": "NORTH",
                                "stayOn": false,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.8532862,
                                "lat": 9.0194929,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 202.75,
                                "relativeDirection": "CIRCLE_CLOCKWISE",
                                "streetName": "road",
                                "absoluteDirection": "WEST",
                                "exit": "4",
                                "stayOn": false,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.8526753,
                                "lat": 9.0203494,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 148.67,
                                "relativeDirection": "HARD_LEFT",
                                "streetName": "YK_13_0605 Street",
                                "absoluteDirection": "WEST",
                                "stayOn": false,
                                "area": false,
                                "bogusName": false,
                                "lon": 38.851778,
                                "lat": 9.0212931,
                                "elevation": "",
                                "walkingBike": false
                            }
                        ],
                        "rentedBike": false,
                        "walkingBike": false,
                        "duration": 437
                    },
                    {
                        "startTime": 1684315997000,
                        "endTime": 1684318471000,
                        "departureDelay": 0,
                        "arrivalDelay": 0,
                        "realTime": false,
                        "isNonExactFrequency": true,
                        "headway": 300,
                        "distance": 12903.84,
                        "generalizedCost": 3374,
                        "pathway": false,
                        "mode": "BUS",
                        "transitLeg": true,
                        "route": "Ayat ↔ Tor Hailoch (Light Rail)",
                        "agencyName": "Addis Ababa Transport (all)",
                        "agencyUrl": "https://example.com",
                        "agencyTimeZoneOffset": 10800000,
                        "routeColor": "1779c2",
                        "routeType": 3,
                        "routeId": "1:1:5697658",
                        "routeTextColor": "FFFFFF",
                        "interlineWithPreviousLeg": false,
                        "headsign": "Tor Hailoch",
                        "agencyId": "1:AA",
                        "tripId": "1:1:177",
                        "serviceDate": "2023-05-17",
                        "from": {
                            "name": "C.M.C",
                            "stopId": "1:1:way/604046026",
                            "lon": 38.8504558,
                            "lat": 9.0210263,
                            "arrival": 1684315697000,
                            "departure": 1684315997000,
                            "stopIndex": 2,
                            "stopSequence": 2,
                            "vertexType": "TRANSIT"
                        },
                        "to": {
                            "name": "St. Lideta",
                            "stopId": "1:1:way/758926928",
                            "lon": 38.735902,
                            "lat": 9.0114191,
                            "arrival": 1684318471000,
                            "departure": 1684318471000,
                            "stopIndex": 19,
                            "stopSequence": 19,
                            "vertexType": "TRANSIT"
                        },
                        "intermediateStops": [
                            {
                                "name": "St. Michael",
                                "stopId": "1:1:way/758915883",
                                "lon": 38.8426345,
                                "lat": 9.0214511,
                                "arrival": 1684315794000,
                                "departure": 1684316154000,
                                "stopIndex": 3,
                                "stopSequence": 3,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Civil Service College",
                                "stopId": "1:1:way/758919090",
                                "lon": 38.8347978,
                                "lat": 9.0217687,
                                "arrival": 1684315957000,
                                "departure": 1684316317000,
                                "stopIndex": 4,
                                "stopSequence": 4,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Management Institute",
                                "stopId": "1:1:way/758919088",
                                "lon": 38.8283604,
                                "lat": 9.0209051,
                                "arrival": 1684316107000,
                                "departure": 1684316467000,
                                "stopIndex": 5,
                                "stopSequence": 5,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Gurd Sholla 1",
                                "stopId": "1:1:way/758922755",
                                "lon": 38.8199363,
                                "lat": 9.0191374,
                                "arrival": 1684316268000,
                                "departure": 1684316628000,
                                "stopIndex": 6,
                                "stopSequence": 6,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Gurd Sholla 2",
                                "stopId": "1:1:way/758922753",
                                "lon": 38.8101826,
                                "lat": 9.0202705,
                                "arrival": 1684316455000,
                                "departure": 1684316815000,
                                "stopIndex": 7,
                                "stopSequence": 7,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Megenagna",
                                "stopId": "1:1:way/758922751",
                                "lon": 38.8026662,
                                "lat": 9.0196319,
                                "arrival": 1684316619000,
                                "departure": 1684316979000,
                                "stopIndex": 8,
                                "stopSequence": 8,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Lem Hotel",
                                "stopId": "1:1:way/758922747",
                                "lon": 38.7958715,
                                "lat": 9.0179703,
                                "arrival": 1684316761000,
                                "departure": 1684317121000,
                                "stopIndex": 9,
                                "stopSequence": 9,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Hayahulet 1",
                                "stopId": "1:1:way/758922745",
                                "lon": 38.7893058,
                                "lat": 9.0162805,
                                "arrival": 1684316913000,
                                "departure": 1684317273000,
                                "stopIndex": 10,
                                "stopSequence": 10,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Hayahulet 2",
                                "stopId": "1:1:way/758922743",
                                "lon": 38.7832128,
                                "lat": 9.0149133,
                                "arrival": 1684317053000,
                                "departure": 1684317413000,
                                "stopIndex": 11,
                                "stopSequence": 11,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "St. Urael",
                                "stopId": "1:1:way/758922741",
                                "lon": 38.7747052,
                                "lat": 9.010991,
                                "arrival": 1684317227000,
                                "departure": 1684317587000,
                                "stopIndex": 12,
                                "stopSequence": 12,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Bambis",
                                "stopId": "1:1:way/758922739",
                                "lon": 38.7688,
                                "lat": 9.0104366,
                                "arrival": 1684317366000,
                                "departure": 1684317726000,
                                "stopIndex": 13,
                                "stopSequence": 13,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "St. Estifanos",
                                "stopId": "1:1:way/758926938",
                                "lon": 38.7634148,
                                "lat": 9.0110867,
                                "arrival": 1684317499000,
                                "departure": 1684317859000,
                                "stopIndex": 14,
                                "stopSequence": 14,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Stadium",
                                "stopId": "1:1:way/758926936",
                                "lon": 38.7576813,
                                "lat": 9.0120397,
                                "arrival": 1684317631000,
                                "departure": 1684317991000,
                                "stopIndex": 15,
                                "stopSequence": 15,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Leghar",
                                "stopId": "1:1:way/758926933",
                                "lon": 38.7536449,
                                "lat": 9.0118976,
                                "arrival": 1684317739000,
                                "departure": 1684318099000,
                                "stopIndex": 16,
                                "stopSequence": 16,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Mexico",
                                "stopId": "1:1:way/758926932",
                                "lon": 38.7486304,
                                "lat": 9.0111035,
                                "arrival": 1684317869000,
                                "departure": 1684318229000,
                                "stopIndex": 17,
                                "stopSequence": 17,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Tegbared",
                                "stopId": "1:1:way/758926930",
                                "lon": 38.7425261,
                                "lat": 9.0105721,
                                "arrival": 1684318005000,
                                "departure": 1684318365000,
                                "stopIndex": 18,
                                "stopSequence": 18,
                                "vertexType": "TRANSIT"
                            }
                        ],
                        "legGeometry": {
                            "points": "c|`v@i~blF??YvKSrISrII`EEhCCnC?????BE~CEtBI~FUvNKzGGnF?@????MnFElEC|A?`BBfAB|@Ht@Nx@Rv@rAfEZ`A\\\\lA????@@l@vBl@rBx@tCnA`EhArD^`BZpBRfAHhAFhB?z@?hACh@?f@Gn@O|ASbB?B???@q@pF[xCOvAIvAObFI~DI~CI~CG`CGjCE~@I`AM`AKbASdB?@??SdB_@fEC~AJrBJ|ALjAlAhLVvDZfE@F????Fh@Dr@FzADd@F`@F`@Nh@NdAj@`FbAnF~@lDf@vBt@|D?B??p@pCRv@v@pEVjAh@~D`@rCz@tFp@lF????RxAn@`FTjBZxBx@tFf@~Dj@rDHp@@B??@BPbAZtAZtBDZDPfAlDd@tANj@L\\\\lA|C`BzD`BdDb@`ArAfD\\\\|@lAlCVt@Rj@@@??LXRf@t@nBh@`Bh@jCLbB?zACdBQnCIpAIhAKvAKnA???@Cv@UjFCf@At@GrA_@`EYpC_@~F?H????e@bIaBtOo@lGCR??A@WtBK`B@fAN`Dj@zFBpA@P???BFdBHfDF`AXpFLnCDn@Fn@Hh@Nf@Rf@Zn@BF????d@dANTDLJ~@BZH~CJzBZ`GHrCCp@?TMdDMxAAH????eDxg@?R",
                            "length": 213
                        },
                        "steps": [],
                        "routeShortName": "E-W",
                        "routeLongName": "Ayat ↔ Tor Hailoch (Light Rail)",
                        "duration": 2474
                    },
                    {
                        "startTime": 1684318471000,
                        "endTime": 1684318763000,
                        "departureDelay": 0,
                        "arrivalDelay": 0,
                        "realTime": false,
                        "distance": 355.29,
                        "generalizedCost": 546,
                        "pathway": false,
                        "mode": "WALK",
                        "transitLeg": false,
                        "route": "",
                        "agencyTimeZoneOffset": 10800000,
                        "interlineWithPreviousLeg": false,
                        "from": {
                            "name": "St. Lideta",
                            "stopId": "1:1:way/758926928",
                            "lon": 38.735902,
                            "lat": 9.0114191,
                            "arrival": 1684318471000,
                            "departure": 1684318471000,
                            "vertexType": "TRANSIT"
                        },
                        "to": {
                            "name": "Bekele Weya Street, Lideta, Addis Ababa, 7777, Ethiopia",
                            "lon": 38.733713,
                            "lat": 9.0109093,
                            "arrival": 1684318763000,
                            "vertexType": "NORMAL"
                        },
                        "legGeometry": {
                            "points": "i`_v@krlkFG?Et@El@C^Gv@Eb@Ed@AJCFEFGNEDCDCFAHAF@F@FBFBDDDFBDBF@F?F?HCHERIJ?P?\\\\BVBR@@x@",
                            "length": 36
                        },
                        "steps": [
                            {
                                "distance": 171.7,
                                "relativeDirection": "DEPART",
                                "streetName": "Chad Street",
                                "absoluteDirection": "WEST",
                                "stayOn": false,
                                "area": false,
                                "bogusName": false,
                                "lon": 38.7359056,
                                "lat": 9.0114513,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 80.8,
                                "relativeDirection": "CIRCLE_COUNTERCLOCKWISE",
                                "streetName": "road",
                                "absoluteDirection": "NORTHWEST",
                                "exit": "5",
                                "stayOn": false,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.7343774,
                                "lat": 9.0117304,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 71.55,
                                "relativeDirection": "CONTINUE",
                                "streetName": "link",
                                "absoluteDirection": "SOUTHEAST",
                                "stayOn": false,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.7340013,
                                "lat": 9.0114486,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 31.24,
                                "relativeDirection": "RIGHT",
                                "streetName": "road",
                                "absoluteDirection": "WEST",
                                "stayOn": true,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.7340005,
                                "lat": 9.0108205,
                                "elevation": "",
                                "walkingBike": false
                            }
                        ],
                        "rentedBike": false,
                        "walkingBike": false,
                        "duration": 292
                    }
                ],
                "tooSloped": false,
                "arrivedAtDestinationWithRentedBicycle": false
            },
            {
                "duration": 3503,
                "startTime": 1684317780000,
                "endTime": 1684321283000,
                "walkTime": 729,
                "transitTime": 2474,
                "waitingTime": 300,
                "walkDistance": 899.49,
                "walkLimitExceeded": false,
                "generalizedCost": 4756,
                "elevationLost": 0,
                "elevationGained": 0,
                "transfers": 0,
                "fare": {
                    "fare": {},
                    "details": {}
                },
                "legs": [
                    {
                        "startTime": 1684317780000,
                        "endTime": 1684318217000,
                        "departureDelay": 0,
                        "arrivalDelay": 0,
                        "realTime": false,
                        "distance": 544.2,
                        "generalizedCost": 834,
                        "pathway": false,
                        "mode": "WALK",
                        "transitLeg": false,
                        "route": "",
                        "agencyTimeZoneOffset": 10800000,
                        "interlineWithPreviousLeg": false,
                        "from": {
                            "name": "Sunshine Apartments, YK_13_0605 St., Yedejazmach Alula Irsha, Addis Ababa, 5648, Ethiopia",
                            "lon": 38.8531855,
                            "lat": 9.0194957,
                            "departure": 1684317780000,
                            "vertexType": "NORMAL"
                        },
                        "to": {
                            "name": "C.M.C",
                            "stopId": "1:1:way/604046026",
                            "lon": 38.8504558,
                            "lat": 9.0210263,
                            "arrival": 1684318217000,
                            "departure": 1684318517000,
                            "vertexType": "TRANSIT"
                        },
                        "legGeometry": {
                            "points": "yr`v@_pclFE?]A?f@AVElB]EUEEAICWKa@SJb@Fd@Ef@Qb@OPCBWN_@La@BE?e@GOGOI\\\\hADXBVAl@A~@A\\\\R?",
                            "length": 32
                        },
                        "steps": [
                            {
                                "distance": 192.78,
                                "relativeDirection": "DEPART",
                                "streetName": "road",
                                "absoluteDirection": "NORTH",
                                "stayOn": false,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.8532862,
                                "lat": 9.0194929,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 202.75,
                                "relativeDirection": "CIRCLE_CLOCKWISE",
                                "streetName": "road",
                                "absoluteDirection": "WEST",
                                "exit": "4",
                                "stayOn": false,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.8526753,
                                "lat": 9.0203494,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 148.67,
                                "relativeDirection": "HARD_LEFT",
                                "streetName": "YK_13_0605 Street",
                                "absoluteDirection": "WEST",
                                "stayOn": false,
                                "area": false,
                                "bogusName": false,
                                "lon": 38.851778,
                                "lat": 9.0212931,
                                "elevation": "",
                                "walkingBike": false
                            }
                        ],
                        "rentedBike": false,
                        "walkingBike": false,
                        "duration": 437
                    },
                    {
                        "startTime": 1684318517000,
                        "endTime": 1684320991000,
                        "departureDelay": 0,
                        "arrivalDelay": 0,
                        "realTime": false,
                        "isNonExactFrequency": true,
                        "headway": 300,
                        "distance": 12903.84,
                        "generalizedCost": 3374,
                        "pathway": false,
                        "mode": "BUS",
                        "transitLeg": true,
                        "route": "Ayat ↔ Tor Hailoch (Light Rail)",
                        "agencyName": "Addis Ababa Transport (all)",
                        "agencyUrl": "https://example.com",
                        "agencyTimeZoneOffset": 10800000,
                        "routeColor": "1779c2",
                        "routeType": 3,
                        "routeId": "1:1:5697658",
                        "routeTextColor": "FFFFFF",
                        "interlineWithPreviousLeg": false,
                        "headsign": "Tor Hailoch",
                        "agencyId": "1:AA",
                        "tripId": "1:1:177",
                        "serviceDate": "2023-05-17",
                        "from": {
                            "name": "C.M.C",
                            "stopId": "1:1:way/604046026",
                            "lon": 38.8504558,
                            "lat": 9.0210263,
                            "arrival": 1684318217000,
                            "departure": 1684318517000,
                            "stopIndex": 2,
                            "stopSequence": 2,
                            "vertexType": "TRANSIT"
                        },
                        "to": {
                            "name": "St. Lideta",
                            "stopId": "1:1:way/758926928",
                            "lon": 38.735902,
                            "lat": 9.0114191,
                            "arrival": 1684320991000,
                            "departure": 1684320991000,
                            "stopIndex": 19,
                            "stopSequence": 19,
                            "vertexType": "TRANSIT"
                        },
                        "intermediateStops": [
                            {
                                "name": "St. Michael",
                                "stopId": "1:1:way/758915883",
                                "lon": 38.8426345,
                                "lat": 9.0214511,
                                "arrival": 1684318314000,
                                "departure": 1684318674000,
                                "stopIndex": 3,
                                "stopSequence": 3,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Civil Service College",
                                "stopId": "1:1:way/758919090",
                                "lon": 38.8347978,
                                "lat": 9.0217687,
                                "arrival": 1684318477000,
                                "departure": 1684318837000,
                                "stopIndex": 4,
                                "stopSequence": 4,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Management Institute",
                                "stopId": "1:1:way/758919088",
                                "lon": 38.8283604,
                                "lat": 9.0209051,
                                "arrival": 1684318627000,
                                "departure": 1684318987000,
                                "stopIndex": 5,
                                "stopSequence": 5,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Gurd Sholla 1",
                                "stopId": "1:1:way/758922755",
                                "lon": 38.8199363,
                                "lat": 9.0191374,
                                "arrival": 1684318788000,
                                "departure": 1684319148000,
                                "stopIndex": 6,
                                "stopSequence": 6,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Gurd Sholla 2",
                                "stopId": "1:1:way/758922753",
                                "lon": 38.8101826,
                                "lat": 9.0202705,
                                "arrival": 1684318975000,
                                "departure": 1684319335000,
                                "stopIndex": 7,
                                "stopSequence": 7,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Megenagna",
                                "stopId": "1:1:way/758922751",
                                "lon": 38.8026662,
                                "lat": 9.0196319,
                                "arrival": 1684319139000,
                                "departure": 1684319499000,
                                "stopIndex": 8,
                                "stopSequence": 8,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Lem Hotel",
                                "stopId": "1:1:way/758922747",
                                "lon": 38.7958715,
                                "lat": 9.0179703,
                                "arrival": 1684319281000,
                                "departure": 1684319641000,
                                "stopIndex": 9,
                                "stopSequence": 9,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Hayahulet 1",
                                "stopId": "1:1:way/758922745",
                                "lon": 38.7893058,
                                "lat": 9.0162805,
                                "arrival": 1684319433000,
                                "departure": 1684319793000,
                                "stopIndex": 10,
                                "stopSequence": 10,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Hayahulet 2",
                                "stopId": "1:1:way/758922743",
                                "lon": 38.7832128,
                                "lat": 9.0149133,
                                "arrival": 1684319573000,
                                "departure": 1684319933000,
                                "stopIndex": 11,
                                "stopSequence": 11,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "St. Urael",
                                "stopId": "1:1:way/758922741",
                                "lon": 38.7747052,
                                "lat": 9.010991,
                                "arrival": 1684319747000,
                                "departure": 1684320107000,
                                "stopIndex": 12,
                                "stopSequence": 12,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Bambis",
                                "stopId": "1:1:way/758922739",
                                "lon": 38.7688,
                                "lat": 9.0104366,
                                "arrival": 1684319886000,
                                "departure": 1684320246000,
                                "stopIndex": 13,
                                "stopSequence": 13,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "St. Estifanos",
                                "stopId": "1:1:way/758926938",
                                "lon": 38.7634148,
                                "lat": 9.0110867,
                                "arrival": 1684320019000,
                                "departure": 1684320379000,
                                "stopIndex": 14,
                                "stopSequence": 14,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Stadium",
                                "stopId": "1:1:way/758926936",
                                "lon": 38.7576813,
                                "lat": 9.0120397,
                                "arrival": 1684320151000,
                                "departure": 1684320511000,
                                "stopIndex": 15,
                                "stopSequence": 15,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Leghar",
                                "stopId": "1:1:way/758926933",
                                "lon": 38.7536449,
                                "lat": 9.0118976,
                                "arrival": 1684320259000,
                                "departure": 1684320619000,
                                "stopIndex": 16,
                                "stopSequence": 16,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Mexico",
                                "stopId": "1:1:way/758926932",
                                "lon": 38.7486304,
                                "lat": 9.0111035,
                                "arrival": 1684320389000,
                                "departure": 1684320749000,
                                "stopIndex": 17,
                                "stopSequence": 17,
                                "vertexType": "TRANSIT"
                            },
                            {
                                "name": "Tegbared",
                                "stopId": "1:1:way/758926930",
                                "lon": 38.7425261,
                                "lat": 9.0105721,
                                "arrival": 1684320525000,
                                "departure": 1684320885000,
                                "stopIndex": 18,
                                "stopSequence": 18,
                                "vertexType": "TRANSIT"
                            }
                        ],
                        "legGeometry": {
                            "points": "c|`v@i~blF??YvKSrISrII`EEhCCnC?????BE~CEtBI~FUvNKzGGnF?@????MnFElEC|A?`BBfAB|@Ht@Nx@Rv@rAfEZ`A\\\\lA????@@l@vBl@rBx@tCnA`EhArD^`BZpBRfAHhAFhB?z@?hACh@?f@Gn@O|ASbB?B???@q@pF[xCOvAIvAObFI~DI~CI~CG`CGjCE~@I`AM`AKbASdB?@??SdB_@fEC~AJrBJ|ALjAlAhLVvDZfE@F????Fh@Dr@FzADd@F`@F`@Nh@NdAj@`FbAnF~@lDf@vBt@|D?B??p@pCRv@v@pEVjAh@~D`@rCz@tFp@lF????RxAn@`FTjBZxBx@tFf@~Dj@rDHp@@B??@BPbAZtAZtBDZDPfAlDd@tANj@L\\\\lA|C`BzD`BdDb@`ArAfD\\\\|@lAlCVt@Rj@@@??LXRf@t@nBh@`Bh@jCLbB?zACdBQnCIpAIhAKvAKnA???@Cv@UjFCf@At@GrA_@`EYpC_@~F?H????e@bIaBtOo@lGCR??A@WtBK`B@fAN`Dj@zFBpA@P???BFdBHfDF`AXpFLnCDn@Fn@Hh@Nf@Rf@Zn@BF????d@dANTDLJ~@BZH~CJzBZ`GHrCCp@?TMdDMxAAH????eDxg@?R",
                            "length": 213
                        },
                        "steps": [],
                        "routeShortName": "E-W",
                        "routeLongName": "Ayat ↔ Tor Hailoch (Light Rail)",
                        "duration": 2474
                    },
                    {
                        "startTime": 1684320991000,
                        "endTime": 1684321283000,
                        "departureDelay": 0,
                        "arrivalDelay": 0,
                        "realTime": false,
                        "distance": 355.29,
                        "generalizedCost": 546,
                        "pathway": false,
                        "mode": "WALK",
                        "transitLeg": false,
                        "route": "",
                        "agencyTimeZoneOffset": 10800000,
                        "interlineWithPreviousLeg": false,
                        "from": {
                            "name": "St. Lideta",
                            "stopId": "1:1:way/758926928",
                            "lon": 38.735902,
                            "lat": 9.0114191,
                            "arrival": 1684320991000,
                            "departure": 1684320991000,
                            "vertexType": "TRANSIT"
                        },
                        "to": {
                            "name": "Bekele Weya Street, Lideta, Addis Ababa, 7777, Ethiopia",
                            "lon": 38.733713,
                            "lat": 9.0109093,
                            "arrival": 1684321283000,
                            "vertexType": "NORMAL"
                        },
                        "legGeometry": {
                            "points": "i`_v@krlkFG?Et@El@C^Gv@Eb@Ed@AJCFEFGNEDCDCFAHAF@F@FBFBDDDFBDBF@F?F?HCHERIJ?P?\\\\BVBR@@x@",
                            "length": 36
                        },
                        "steps": [
                            {
                                "distance": 171.7,
                                "relativeDirection": "DEPART",
                                "streetName": "Chad Street",
                                "absoluteDirection": "WEST",
                                "stayOn": false,
                                "area": false,
                                "bogusName": false,
                                "lon": 38.7359056,
                                "lat": 9.0114513,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 80.8,
                                "relativeDirection": "CIRCLE_COUNTERCLOCKWISE",
                                "streetName": "road",
                                "absoluteDirection": "NORTHWEST",
                                "exit": "5",
                                "stayOn": false,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.7343774,
                                "lat": 9.0117304,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 71.55,
                                "relativeDirection": "CONTINUE",
                                "streetName": "link",
                                "absoluteDirection": "SOUTHEAST",
                                "stayOn": false,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.7340013,
                                "lat": 9.0114486,
                                "elevation": "",
                                "walkingBike": false
                            },
                            {
                                "distance": 31.24,
                                "relativeDirection": "RIGHT",
                                "streetName": "road",
                                "absoluteDirection": "WEST",
                                "stayOn": true,
                                "area": false,
                                "bogusName": true,
                                "lon": 38.7340005,
                                "lat": 9.0108205,
                                "elevation": "",
                                "walkingBike": false
                            }
                        ],
                        "rentedBike": false,
                        "walkingBike": false,
                        "duration": 292
                    }
                ],
                "tooSloped": false,
                "arrivedAtDestinationWithRentedBicycle": false
            }
        ]
    },
    "metadata": {
        "searchWindowUsed": 4800,
        "nextDateTime": 1684317840000,
        "prevDateTime": 1684308240000
    },
    "previousPageCursor": "rO0ABXc1AQANUFJFVklPVVNfUEFHRQZYkgCAAAAAAAAg0AAXU1RSRUVUX0FORF9BUlJJVkFMX1RJTUU=",
    "nextPageCursor": "rO0ABXcxAQAJTkVYVF9QQUdFBljFkIAAAAAAACDQABdTVFJFRVRfQU5EX0FSUklWQUxfVElNRQ==",
    "debugOutput": {
        "precalculationTime": 5528400,
        "directStreetRouterTime": 175734400,
        "transitRouterTime": 615820800,
        "filteringTime": 59380699,
        "renderingTime": 24615100,
        "totalTime": 881246600,
        "transitRouterTimes": {
            "tripPatternFilterTime": 219074700,
            "accessEgressTime": 64208901,
            "raptorSearchTime": 243140401,
            "itineraryCreationTime": 88892500
        }
    },
    "elevationMetadata": {
        "ellipsoidToGeoidDifference": -7.085139174509318,
        "geoidElevation": false
    }
}""";